<?php
defined('BASEPATH') OR exit('No direct script access allowed');

$logClassFile = dirname(__FILE__) . '/Logs.php';
require_once $logClassFile;

class Imgs extends Logs
{
	function __construct()
	{

	}
	
	/**
	 * マイクロタイムの取得
	 */
	private function getMicroTime()
	{
		return str_replace(array(' ', '.'), '', microtime());
	}
	
	/**
	 * 画像を縮小する
	 *
     * @param String $extension        拡張子         
	 * @param String $filenameSource	対象の画像ファイル名(*.jpg)
	 * @param String $filenameTarget	書き出し先ファイル名(*.jpg)
	 * @param int $specifiedWidth		目的の幅(px)
	 * @param int $specifiedHeight		目的の高さ(px)
	 * @param int $quality				JPEGのクォリティ
	 * @return bool
	 **/
	public function resizeImage($extension, $filenameSource, $filenameTarget, $specifiedWidth, $specifiedHeight, $quality = 90)
	{
		// ファイルのサイズを取得する
		list($widthOrig, $heightOrig) = getimagesize($filenameSource);

		if ($widthOrig > $specifiedWidth && $heightOrig > $specifiedHeight) {
			if ($specifiedWidth < $specifiedHeight) {
				$height = ($specifiedWidth / $widthOrig) * $heightOrig;
				$width = $specifiedWidth;
				if ($height > $specifiedHeight) {
					$height = $specifiedHeight;
					$width = ($specifiedHeight / $heightOrig) * $widthOrig;
				}
			} elseif ($specifiedWidth > $specifiedHeight) {
				$width = ($specifiedHeight / $heightOrig) * $widthOrig;
				$height = $specifiedHeight;
				if ($width > $specifiedWidth) {
					$width = $specifiedWidth;
					$height = ($specifiedWidth / $widthOrig) * $heightOrig;
				}
			} elseif ($specifiedWidth == $specifiedHeight) {
				if ($widthOrig < $heightOrig) {
					$height = $specifiedHeight;
					$width = ($specifiedHeight / $heightOrig) * $widthOrig;
				} else {
					$width = $specifiedWidth;
					$height = ($specifiedWidth / $widthOrig) * $heightOrig;
				}
			}
		} elseif ($widthOrig > $specifiedWidth) {
			$width = $specifiedWidth;
			$height = ($specifiedWidth / $widthOrig) * $heightOrig;
		} elseif ($heightOrig > $specifiedHeight) {
			$width = ($specifiedHeight / $heightOrig) * $widthOrig;
			$height = $specifiedHeight;
		} else {
			$width = $widthOrig;
			$height = $heightOrig;
		}

		// 再サンプル
		$imageP = imagecreatetruecolor($width, $height);

		switch ($extension) {
			case 'image/jpeg':
				$image = imagecreatefromjpeg($filenameSource);
				imagecopyresampled($imageP, $image, 0, 0, 0, 0, $width, $height, $widthOrig, $heightOrig);
				break;
			case 'image/gif':
				$image = imagecreatefromgif($filenameSource);
				imagecopyresampled($imageP, $image, 0, 0, 0, 0, $width, $height, $widthOrig, $heightOrig);
				break;
			case 'image/bmp':
				$image = self::imagecreatefrombmp($filenameSource);
				imagecopyresampled($imageP, $image, 0, 0, 0, 0, $width, $height, $widthOrig, $heightOrig);
				break;
			case 'image/png':
				$image = imagecreatefrompng($filenameSource);
				imagecopyresampled($imageP, $image, 0, 0, 0, 0, $width, $height, $widthOrig, $heightOrig);
				break;
		}

		return imagejpeg($imageP, $filenameTarget, $quality);
	}
	
	private function imagecreatefrombmp($filename)
	{
		//Ouverture du fichier en mode binaire
		if (!$f1 = fopen($filename, 'rb')) {
			return false;
		}

		$file = unpack("vfile_type/Vfile_size/Vreserved/Vbitmap_offset", fread($f1, 14));
		
		if ($file['file_type'] != 19778) {
			return false;
		}

		$bmp = unpack('Vheader_size/Vwidth/Vheight/vplanes/vbits_per_pixel'.
					  '/Vcompression/Vsize_bitmap/Vhoriz_resolution'.
					  '/Vvert_resolution/Vcolors_used/Vcolors_important', fread($f1, 40));

		$bmp['colors'] = pow(2, $bmp['bits_per_pixel']);
		
		if ($bmp['size_bitmap'] == 0) {
			$bmp['size_bitmap'] = $file['file_size'] - $file['bitmap_offset'];
		}

		$bmp['bytes_per_pixel'] = $bmp['bits_per_pixel'] / 8;
		$bmp['bytes_per_pixel2'] = ceil($bmp['bytes_per_pixel']);
		$bmp['decal'] = ($bmp['width'] * $bmp['bytes_per_pixel'] / 4);
		$bmp['decal'] -= floor($bmp['width'] * $bmp['bytes_per_pixel'] / 4);
		$bmp['decal'] = 4 - (4 * $bmp['decal']);
		
		if ($bmp['decal'] == 4) {
			$bmp['decal'] = 0;
		}

		$palette = array();

		if ($bmp['colors'] < 16777216) {
			$palette = unpack('V' . $bmp['colors'], fread($f1, $bmp['colors'] * 4));
		}

		$img = fread($f1, $bmp['size_bitmap']);
		$vide = chr(0);

		$res = imagecreatetruecolor($bmp['width'], $bmp['height']);
		$P = 0;
		$Y = $bmp['height'] - 1;

		while ($Y >= 0) {
			$X = 0;
			while ($X < $bmp['width']) {
				if ($bmp['bits_per_pixel'] == 24) {
					$color = unpack("V", substr($img, $P, 3) . $vide);
				} elseif ($bmp['bits_per_pixel'] == 16) {
					$color = unpack("n", substr($img, $P, 2));
					$color[1] = $palette[$color[1] + 1];
				} elseif ($bmp['bits_per_pixel'] == 8) {  
					$color = unpack("n", $vide . substr($img, $P, 1));
					$color[1] = $palette[$color[1] + 1];
				} elseif ($bmp['bits_per_pixel'] == 4) {
					$color = unpack("n", $vide . substr($img, floor($P), 1));
				if (($P * 2) % 2 == 0) $color[1] = ($color[1] >> 4) ; else $color[1] = ($color[1] & 0x0F);
					$color[1] = $palette[$color[1] + 1];
				} elseif ($bmp['bits_per_pixel'] == 1) {
					$color = unpack("n", $vide . substr($img, floor($P), 1));

					if (($P * 8) % 8 == 0) $color[1] =  $color[1] >> 7;
					elseif (($P * 8) % 8 == 1) $color[1] = ($color[1] & 0x40) >> 6;
					elseif (($P * 8) % 8 == 2) $color[1] = ($color[1] & 0x20) >> 5;
					elseif (($P * 8) % 8 == 3) $color[1] = ($color[1] & 0x10) >> 4;
					elseif (($P * 8) % 8 == 4) $color[1] = ($color[1] & 0x8) >> 3;
					elseif (($P * 8) % 8 == 5) $color[1] = ($color[1] & 0x4) >> 2;
					elseif (($P * 8) % 8 == 6) $color[1] = ($color[1] & 0x2) >> 1;
					elseif (($P * 8) % 8 == 7) $color[1] = ($color[1] & 0x1);

					$color[1] = $palette[$color[1] + 1];
				} else {
					return false;
				}

				imagesetpixel($res,$X,$Y,$color[1]);

				$X++;
				$P += $bmp['bytes_per_pixel'];
			}
			$Y--;
			$P+=$bmp['decal'];
		}

		fclose($f1);

		return $res;
	}
	
	private function imagebmp($im, $fn = false)
	{
		if (!$im) return false;

		if ($fn === false) $fn = 'php://output';

		$f = fopen ($fn, "w");

		if (!$f) return false;

		//Image dimensions
		$biWidth = imagesx ($im);
		$biHeight = imagesy ($im);
		$biBPLine = $biWidth * 3;
		$biStride = ($biBPLine + 3) & ~3;
		$biSizeImage = $biStride * $biHeight;
		$bfOffBits = 54;
		$bfSize = $bfOffBits + $biSizeImage;

		//BITMAPFILEHEADER
		fwrite ($f, 'BM', 2);
		fwrite ($f, pack ('VvvV', $bfSize, 0, 0, $bfOffBits));

		//BITMAPINFO (BITMAPINFOHEADER)
		fwrite ($f, pack ('VVVvvVVVVVV', 40, $biWidth, $biHeight, 1, 24, 0, $biSizeImage, 0, 0, 0, 0));

		$numpad = $biStride - $biBPLine;

		for ($y = $biHeight - 1; $y >= 0; --$y) {
			for ($x = 0; $x < $biWidth; ++$x) {
				$col = imagecolorat ($im, $x, $y);
				fwrite ($f, pack ('V', $col), 3);
			}
			for ($i = 0; $i < $numpad; ++$i)

			fwrite ($f, pack ('C', 0));
		}

		fclose ($f);

		return true;
	}
	
	/**
	 * 画像切り抜き
	 * @param string $srcImg	元画像ファイル
	 * @param string $prefix	接頭辞
	 * @param string $saveDir	保存ディレクトリ
	 * @param int $trimW		切り出し横幅サイズ
	 * @param int $trimH		切り出し縦幅サイズ
	 * @param int $quality		クオリティ（gif以外）
	 * @return string
	 */
	public function trimImg($srcImg, $prefix = '', $saveDir = '', $trimW = 0, $trimH = 0, $quality = 90)
	{
		if (!file_exists($srcImg) || empty($srcImg) || empty($saveDir)) {
			return false;
		}

		// get img size
		list($orgW, $orgH) = getimagesize($srcImg);
		
		$x = floor(($orgW - $trimW) / 2);
		$y = floor(($orgH - $trimH) / 2);
		
		// Get extension
		preg_match('/\.(.*)$/', $srcImg, $matches);
		$extension = $matches[1];
		
		if (empty($extension)) {
			return false;
		}
		
		// create img file name.
		$name = sprintf('%s_%s.%s', $prefix, self::getMicroTime(), $extension);
		$dest = imagecreatetruecolor($trimW, $trimH);
		switch($extension) {
			case 'jpg':
			case 'jpeg':
				$src = imagecreatefromjpeg($srcImg);
				imagecopy($dest, $src, 0, 0, $x, $y, $orgW, $orgH);
				imagejpeg($dest, $saveDir . $name, $quality);
				break;
			case 'png':
				$src = imagecreatefrompng($srcImg);
				$pngQuality = round($quality / 10);
				imagecopy($dest, $src, 0, 0, $x, $y, $orgW, $orgH);
				imagepng($dest, $saveDir . $name, $pngQuality);
				break;
			case 'gif':
				$src = imagecreatefromgif($srcImg);
				imagecopy($dest, $src, 0, 0, $x, $y, $orgW, $orgH);
				imagegif($dest, $saveDir . $name);
				break;
		}
		imagedestroy($dest);
		
		return file_exists($saveDir . $name) ? $name : false;
	}
	
	/**
	 * 指定した色の単色画像を作成
	 * @param string $saveDir
	 * @param string $rgbCode
	 * @param int $w
	 * @param int $h
	 * @param string $prefix
	 * @param string $extension
	 * @return string
	 */
	public function getColorImg($saveDir, $rgbCode = '#FFFFFF', $w = 100, $h = 100, $prefix = '', $extension = 'jpg')
	{
		if (!file_exists($saveDir)) {
			return false;
		}
		
		$rgb = self::convertColorCodeHexToDec($rgbCode);
		if (empty($rgb)) {
			return false;
		}
		
		$name = sprintf('%s_%s.%s', $prefix, self::getMicroTime(), $extension);
		$dest = imagecreatetruecolor($w, $h);
		$bk = imagecolorallocate($dest, $rgb['r'], $rgb['g'], $rgb['b']);
		imagefilledrectangle($dest, 0, 0, $w, $h, $bk);
		switch($extension) {
			case 'jpg':
			case 'jpeg':
				imagejpeg($dest, $saveDir . $name);
				break;
			case 'png':
				imagepng($dest, $saveDir . $name);
				break;
			case 'gif':
				imagegif($dest, $saveDir . $name);
				break;
			default:
				return false;
		}
		
		return file_exists($saveDir . $name) ? $name : false;
	}
	
	
}