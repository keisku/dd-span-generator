# dd-span-generator

dd-span-generator generates Datadog spans for debugging until it is killed.

Usage

```bash
docker run --rm ghcr.io/keisku/dd-span-generator:latest
```

```bash
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Pod
metadata:
  name: dd-span-generator
  # labels:
  #   pod-label-a: pod-label-a-value
  # annotations:
  #   ad.datadoghq.com/tags: '{"annotation-ad-tag-1": "annotation-ad-tag-1-value"}'
  #   pod-annotation-a: pod-annotation-a-value
spec:
  containers:
  - name: dd-span-generator
    image: ghcr.io/keisku/dd-span-generator:latest
    volumeMounts:
    - name: apmsocketpath
      mountPath: /var/run/datadog
    env:
    - name: DD_SERVICE
      value: span-generator
    # - name: DD_ENV
    #   value: keisuke-sandbox
    - name: DD_RUNTIME_METRICS_ENABLED
      value: "true"
  volumes:
  - hostPath:
      path: /var/run/datadog/
    name: apmsocketpath
EOF
```
