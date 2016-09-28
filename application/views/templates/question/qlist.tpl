{include file="common/header.tpl"}
{assign var="base" value="http://localhost/manavi/"}



<div class="container-fluid">
    <div class="row-fluid">
        <div class="answer_list">
            <div class="answer_comment"><div class="arw"></div>問題を選択してください．</div>
            <table>
                <tr>
                    <th>災害の種類</th>
                    <th>回答</th>
                </tr>
                <tr>
                    <td><a href="http://www.snowwhite.hokkaido.jp/manavi/question/form?question_id=1">地震</a></td>
                    <td>想定:震度7の地震が発生しました</td>
                </tr>
                <tr>
                    <td><a href="http://www.snowwhite.hokkaido.jp/manavi/question/form?question_id=2">石狩水害</a></td>
                    <td>想定:日本海側で大雨が降り、石狩川が氾濫しました</td>
                </tr>
                <tr>
                    <td><a href="http://www.snowwhite.hokkaido.jp/manavi/question/form?question_id=3">豊平水害</a></td>
                    <td>想定:札幌市内で大雨が降り、豊平川が氾濫しました</td>
                </tr>
                <tr>
                    <td><a href="http://www.snowwhite.hokkaido.jp/odhack/getdata.cgi">統計情報</a></td>
                    <td>各問題の回答情報を見ることができます。</td>
                </tr>
            </table>
        </div>

    </div><!--/row-->
    <hr>
</div><!--/.fluid-container-->

{include file="common/footer.tpl"}

