# IPI
![Shell Script](https://img.shields.io/badge/shell_script-%23121011.svg?style=for-the-badge&logo=gnu-bash&logoColor=white)

Shell Script to check IPv4 and IPv6 information. The `curl` tool was used to make an HTTP request to the [ipgeolocation.io](https://ipgeolocation.io/) API, `jq` to process the JSON from the API and `getopts` to process the parameters.

### Adding execute permission to the script

``` bash
    chmod +x ipi.sh
```

### Creating alias for the script

- After downloading, move the script to `/opt`
- Enter the `.bashrc` file and add the alias below:

``` bash
    alias ipi='bash /opt/ipi.sh'
```

## Usage

```sh
./ipi.sh -h
```

<img src="/assets/IPI-h.png">


```sh
./ipi.sh -i 8.8.8.8
```

<img src="/assets/IPI-i.png">
