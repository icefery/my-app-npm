## 一、应用

### 1.1 生成 HTTPS 自签证书

> [How to generate a self-signed SSL certificate using OpenSSL?](https://stackoverflow.com/questions/10175812/how-to-generate-a-self-signed-ssl-certificate-using-openssl)

```shell
DOMAIN="my-app-npm.demo.icefery.xyz"

mkdir -p certs

openssl req -newkey rsa:4096 -nodes -sha256 -keyout certs/domain.key -x509 -days 36500 -out certs/domain.crt -subj "/CN=${DOMAIN}"
```

### 1.2 访问 HTTPS

```shell
curl -k https://my-app-npm.demo.icefery.xyz:8443
```

## 二、发布

### 2.1 发布 NPM 包到 GitHub Packages

- `.npmrc`

  ```shell
  @icefery:registry=https://npm.pkg.github.com
  ```

- `~/.npmrc`

  ```shell
  //npm.pkg.github.com/:_authToken=<GITHUB_TOKEN>
  ```

- `npm publish`

## 三、镜像

### 3.1 构建多平台镜像

```shell
nerdctl run --privileged --rm tonistiigi/binfmt --install all

ls -1 /proc/sys/fs/binfmt_misc/qemu*

nerdctl build --tag my-app-npm:0.0.1 --platform linux/amd64,linux/arm64 .

nerdctl image ls
```

### 3.2 推送多平台部镜像到 Harbor

```shell
nerdctl login http://harbor.demo.icefery.xyz --username=admin --password=admin

nerdctl tag my-app-npm:0.0.1 harbor.demo.icefery.xyz/icefery/my-app-npm:0.0.1

nerdctl push harbor.demo.icefery.xyz/icefery/my-app-npm:0.0.1 --all-platforms
```

## 四、图表

### 4.1 推送图表到 Harbor

```shell
helm plugin install https://github.com/chartmuseum/helm-push

helm repo add icefery http://harbor.demo.icefery.xyz/chartrepo/icefery --username=admin --password=admin

helm cm-push ci/chart icefery
```
