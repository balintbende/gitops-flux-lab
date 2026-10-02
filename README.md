# gitops-flux-lab

Flux is responsible automatically releasing the latest available images of the
bimlens services.

## monorepo with multiple clusters

All environments, plaforms and clusters are in the same repo. One cluster may 
host multiple environments, namespaced.

```
├── apps
│   ├── base
│   ├── dev
│   └── prod
│
└── clusters
    ├── dev
    └── prod
```

In `apps` the different configuration of the services are defined using kustomization
overlays. There is (mostly) a default configuration in the helm chart and in the
`base` version. Then `development` just overrides the values it really needs to.
Every configuration here is specific to a namespace.

In the `clusters` folder, however, the configuration are valid for the whole cluster.
Here is the configuration for common git/ECR repositories, flux-systems etc.

[Repository structure][1]

## working with flux

The initial flux setup and bootstrap is part of terraform.

## troubleshooting

Get flux:
```
$ brew install fluxcd/tap/flux
```

**IMPORTANT: switch to the proper kube context!**
```
$ kubectx bimlens-dev
```

General status:
```
$ flux get all
```

Image automation status:
```
$ flux get images all --all-namespaces
```

Logs:
```
$ flux logs --all-namespaces --follow --tail 50
```

Reconcile flux system services:
```
$ flux reconcile kustomization flux-system --with-source
```

[1]: https://fluxcd.io/docs/guides/repository-structure/
