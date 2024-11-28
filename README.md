# このリポジトリについて
Apple SilliconのMacでAFLを動作させることを目的にしています。
内部でintel CPUの命令セットを使用しているため、仮想環境を使っています
# やり方
1. リポジトリをcloneしてくる

```sh
git clone https://github.com/umiyuri777/AFL_in_docker.git
```

2. docker でビルド（コンパイルまで自動で行う）

```sh
docker buildx build --platform linux/amd64 -t afl-in-docker .
```

3. dockerコンテナを起動

```sh
docker run -itd afl-in-docker 
```

4. コンテナ内に入る

```sh
# 起動したコンテナのコンテナIDを確認
docker ps

#コンテナの中に入る
docker exec -i -t <確認したコンテナID> /bin/bash 
```
4. AFL用にファジングしたいプログラムをコンパイル
```

```

6. AFLを起動

```sh
afl-fuzz -i test_in -o test_out -m none -- ./a.out
```

6. 止めて結果を見る

```sh
# test_outフォルダの中に結果が入るようになってる
cd test_out
```

7. 結果を利用して好きなように分析
