## OTEL Instrumented Golang Web API

### Deploying the emojivoto application

Run the following command:
```hcl
kubectl apply -k github.com/keyval-dev/opentelemetry-go-instrumentation/docs/getting-started/emojivoto
```

### Instrumentation

Apply the automatic instrumentation to the emoji, voting, and web applications by executing the following command:
```hcl
kubectl apply -f https://raw.githubusercontent.com/keyval-dev/opentelemetry-go-instrumentation/master/docs/getting-started/emojivoto-instrumented.yaml -n emojivoto
```

