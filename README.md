# alfred-mackerel-page-workflow

## これは何?

 * [Mackerel](https://mackerel.io/) でHost、Dashboardのページを簡単に開くことが出来るAlfred Workflowです

![](images/alfred-mackerel-page-workflow-animation.gif)

## APIキーとオーガニゼーションの設定

`cisetapi` を実行すると、設定ファイルが開くので、

 * APIキー (読み取り権限)
 * オーガニゼーション

を設定してください

![](images/alfred-mackerel-page-workflow00.png)

## URL情報を取得

`mcu` を実行すると、API経由で、URL情報を取得し、キャッシュファイルに保存します。

![](images/alfred-mackerel-page-workflow01.png)

## Hostページの開く

`mc {hostname}` を実行すると、該当hostのメトリクスページが開きます。

![](images/alfred-mackerel-page-workflow02.png)


## Dashboardページを開く

`mcd {dashboard}` を実行すると、該当Dashboardページを開きます。

![](images/alfred-mackerel-page-workflow03.png)
