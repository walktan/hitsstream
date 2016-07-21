
# Hits Stream

・ 2016/7/21

##■プログラム概要
    iTunesの音楽ランキングに応じたyoutube動画の自動再生webアプリケーション
    (店頭のBGM等への利用を想定)
        - 公開URL : http://www.hitsstream.xyz/
        - フレームワーク : Rails 4.2.6
        - データベース : PostgreSQL 9.4.7 
        - サーバ : Amazon Linux
        - 言語 : Ruby 2.1.8, JavaScript

##■機能概要
    ・バックエンド(以下の処理をcronで1日毎に実行)
    　 ① iTunes RSSから音楽ランキングを取得し、DBに格納する
    　 ② ①の取得結果に、youtube APIより取得したVideoIDを 紐付けてDBに格納する 
    ・ フロントエンド
    　　- iTunesランキングの「集計日」および「集計ジャンル」をインプットとし、
    　　　ランキング結果およびyoutube動画を表示させる
    　　- 1つの動画が終了すると、次のランキング順位の動画を自動再生する
    　　- 再生・ポーズ、NEXT、PREVボタンを設置
    　　- 各動画の右側に[Edit]ボタンを設け、VideoIDを変更
    　　（バックエンドで自動的に取得したVideoIDが不適切な場合、手動で補正するため）
