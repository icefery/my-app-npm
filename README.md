## 应用

#### 生成 HTTPS 自签证书

```bash
DOMAIN="my-app.dev.icefery.xyz"

mkdir -p certs

openssl req -newkey rsa:4096 -nodes -sha256 -keyout certs/domain.key -x509 -days 36500 -out certs/domain.crt -subj "/CN=${DOMAIN}"
```

## 构建镜像

```bash
nerdctl run --privileged --rm tonistiigi/binfmt --install all

ls -1 /proc/sys/fs/binfmt_misc/qemu*
```

```bash
nerdctl build -t icefery/my-app:0.0.1 --platform linux/arm64,linux/amd64 .

nerdctl image ls
```

```bash
nerdctl login http://core.harbor.dev.icefery.xyz --username=admin --password=admin

nerdctl push --all-platforms icefery/my-app:0.0.1
```

## 构建图表

```bash
helm plugin install https://github.com/chartmuseum/helm-push
```

```bash
helm repo add icefery http://core.harbor.dev.icefery.xyz/chartrepo/icefery --username=admin --password=admin
```

```bash
helm cm-push chart/ chartmuseum-library
```
