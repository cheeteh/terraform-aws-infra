## Description

This folder stores the base configuration flux itself for each individual cluster. In this case, there is only `eks-angi`
but more cluster folder can be added here once the `flux-bootstrap-git` setup and specified path is configured.

Under the cluster folder `Kustomization` file can be setup which allow syncs with folder under `infrastructure` to be read.