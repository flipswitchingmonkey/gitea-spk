# gitea-spk

Fork from [gogs-spk](https://github.com/alexandregz/gogs-spk) to create a SPK package for [Gitea](https://github.com/go-gitea/gitea), a [Gogs](https://gogs.io/) fork.

### Dependencies

The Gitea package requires the **[Git Server](https://www.synology.com/en-global/dsm/packages/Git)** package.

### Automatic cron job for updating existing Gitea on Synology NAS - 2020 update

To create automatic cron job for updating your Gitea, clone `cron_gitea_update.sh` file and set it inside Task Schedule to run and update Gitea automatically when new stable release comes up.

You can also run this script manually from SSH console of your NAS, if you want to update it when you are ready, not when new release comes up.

To setup this script, only required changes should be made at lines 24 and 34:

`24: DOWNLOAD_URL=https://github.com/go-gitea/gitea/releases/download/v${GITEA_VERSION}/gitea-${GITEA_VERSION}-linux-XXX.xz`

`34: sudo synopkg install /tmp/gitea/gitea-spk/gitea-${GITEA_VERSION}-linux-XXX.spk`

where instead of `XXX` you should insert your NAS CPU architecture, for example `arm64` or `arm-6` as shown below.

If Gitea package won't start automatically, you can just turn it on in Package Manager.

This script is using gitea-spk packgage from flipswitchingmonkey and was tested with Gitea 1.11 and 1.12 on May and June 2020. Works OK. Huge thanks for [salesgroup](https://github.com/salesgroup) for sharing.

### Package creation

To create the package, clone the repository:

`$ git clone https://github.com/flipswitchingmonkey/gitea-spk.git`

Change into the newly created directory - the root directory:

`$ cd gitea-spk`

Download the Gitea binary matching your architecture from https://github.com/go-gitea/gitea/releases into the root directory. For example, a DiskStation with an ARMv6 (or ARMv7) CPU would require:

`$ wget https://github.com/go-gitea/gitea/releases/download/v1.8.3/gitea-1.8.3-linux-arm-6`

Invoke the build script to have the package created:

`$ ./create_spk.sh`

The install package matching your binary (here `gitea-1.8.3-linux-arm-6.spk`) will be created in the root directory.

If you have several binaries downloaded, you can specify the binary for which the package should be created:

`$ ./create_spk.sh gitea-1.8.3-linux-arm-6`

### Installation

Make sure **Package Center > Settings > General > Trust Level** is set to **Any Publisher** and perform installation via **Package Center > Manual Install**.

![Select Package](screenshots/install_select_package.png)

The installer will create the (internal) user/group gitea:gitea when not found and the executable is run with this user.

![Select Package](screenshots/install_running.png)

When installation has finished, the package center shows url and status of your Gitea server.

When accessed for the first time, Gitea will greet you with the installation settings. You should set your **Repository Root Path** to a shared folder. You can configure permissions for shared folders in the control panel via **Edit > Permissions > System internal user** to grant the Gitea user permission.

Tested to work on DS215j with Gitea v1.8.3 (arm-6).

### Acknowledgements

Original code copyright (c) 2016 Alexandre Espinosa Menor
