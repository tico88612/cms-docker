# Contest Management System Docker Version

## Architecture

TBD

## Notice

With Original CMS difference file only `requirements.txt`, you need to add `markupsafe==2.0.1`

```txt
...
Jinja2>=2.10,<2.11  # http://jinja.pocoo.org/docs/latest/changelog/
markupsafe==2.0.1

# Only for some importers:
pyyaml>=5.3,<5.4  # http://pyyaml.org/wiki/PyYAML
...
```

## Other & TO-DO List

Pull Request Welcome!

- [ ] GitHub Action Build & Push Image
- [ ] Helm Chart Version (Kubernetes)

## Reference project

[np-overflow/k8s-cms](https://github.com/np-overflow/k8s-cms)
