# Contest Management System Docker Version

This version is following [ioi/cms](https://github.com/ioi/cms).

## Support

| System | Support |
| :--- | :---: |
| Ubuntu 20.04 | ✅ |
| Ubuntu 22.04 | ✅, Need to enable cgroup v1 |
| Windows Subsystem Linux (Ubuntu 22.04) | ✅ |
| macOS | ⚠️ |

macOS doesn't support isolate (a.k.a. cmsWorker) running, because cgroups doesn't support macOS.

## Architecture

TBD

## Requirement

### Enable cgroup v1 (Ubuntu 22.04)

Contest Management System is used [ioi/isolate](https://github.com/ioi/isolate/) for sandbox, which is not supported cgroup v2 yet.

In Ubuntu 22.04, cgroup v1 default is not enabled. You need to enable it and reboot.

```bash
#!/bin/bash

echo 'GRUB_CMDLINE_LINUX_DEFAULT="${GRUB_CMDLINE_LINUX_DEFAULT} cgroup_enable=memory swapaccount=1 systemd.unified_cgroup_hierarchy=false systemd.legacy_systemd_cgroup_controller=false"' | sudo tee /etc/default/grub.d/70-cgroup-v1.cfg
sudo update-grub
sudo reboot
```

After that, you will need to check cgroup v1 is enabled.

```bash
mount | grep cgroup
```

This is success example output.

```
ubuntu@cms:~$ mount | grep cgroup
tmpfs on /sys/fs/cgroup type tmpfs (ro,nosuid,nodev,noexec,size=4096k,nr_inodes=1024,mode=755,inode64)
cgroup2 on /sys/fs/cgroup/unified type cgroup2 (rw,nosuid,nodev,noexec,relatime,nsdelegate)
cgroup on /sys/fs/cgroup/systemd type cgroup (rw,nosuid,nodev,noexec,relatime,xattr,name=systemd)
cgroup on /sys/fs/cgroup/pids type cgroup (rw,nosuid,nodev,noexec,relatime,pids)
cgroup on /sys/fs/cgroup/cpu,cpuacct type cgroup (rw,nosuid,nodev,noexec,relatime,cpu,cpuacct)
cgroup on /sys/fs/cgroup/net_cls,net_prio type cgroup (rw,nosuid,nodev,noexec,relatime,net_cls,net_prio)
cgroup on /sys/fs/cgroup/rdma type cgroup (rw,nosuid,nodev,noexec,relatime,rdma)
cgroup on /sys/fs/cgroup/cpuset type cgroup (rw,nosuid,nodev,noexec,relatime,cpuset)
cgroup on /sys/fs/cgroup/freezer type cgroup (rw,nosuid,nodev,noexec,relatime,freezer)
cgroup on /sys/fs/cgroup/memory type cgroup (rw,nosuid,nodev,noexec,relatime,memory)
cgroup on /sys/fs/cgroup/blkio type cgroup (rw,nosuid,nodev,noexec,relatime,blkio)
cgroup on /sys/fs/cgroup/devices type cgroup (rw,nosuid,nodev,noexec,relatime,devices)
cgroup on /sys/fs/cgroup/hugetlb type cgroup (rw,nosuid,nodev,noexec,relatime,hugetlb)
cgroup on /sys/fs/cgroup/misc type cgroup (rw,nosuid,nodev,noexec,relatime,misc)
cgroup on /sys/fs/cgroup/perf_event type cgroup (rw,nosuid,nodev,noexec,relatime,perf_event)
```

### Install Docker

Follow this [manual](https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script) to install Docker.

## Installation

1. Clone this project (include submodules)

```
git clone --recursive https://github.com/tico88612/cms-docker.git
```

2. If you want to change worker number, edit `config/cms.conf` and `docker-compose.yml`

3. Copy `.env.example` to `.env` and edit `CMS_SECRET_KEY`, `CMS_ADMIN_PASSWORD`, `CMS_RANKING_PASSWORD` etc. (Contest has not been created yet, don't touch `CMS_CONTEST_ID` before creating the contest.)

```bash
cp .env.example .env
vim .env # Edit .env
```

4. Build `cms-base:latest` image.

```bash
# Docker build
docker build -f images/cms-base/Dockerfile . -t cms-base:latest
# If you have install Buildx, you can try this
docker buildx build -f images/cms-base/Dockerfile . -t cms-base:latest
```

5. Up all service

```bash
docker compose up -d
```

6. Login to Admin system & Create contest.

```
Contest: http://localhost:8888
Admin: http://localhost:8889
Ranking: http://localhost:8890
```

7. Have fun!

## Other & TO-DO List

Pull Request Welcome!

- [ ] GitHub Action Build & Push Image
- [ ] Helm Chart Version (Kubernetes)

## Reference project

- [np-overflow/k8s-cms](https://github.com/np-overflow/k8s-cms)
- [ioi/cms](https://github.com/ioi/cms)
