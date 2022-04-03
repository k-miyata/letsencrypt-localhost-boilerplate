# Let's Encrypt `localhost`

Manage and back up TLS certificates for `localhost`.

**Warning:** This template is intended to manage certificates for development
use only. Do not use this for production.

## Installation from the template

Click the _Use this template_ button on the top page of this template repository
to create your own repository for managing and backing up your certificates.

**Important:** Don't forget to make your repository private.

## Usage

### Obtaining or renewing a certificate

First, set a comma-separated list of domains to the environment variable
`DOMAINS` in your own `.env` file, for example:

```sh
DOMAINS=example.com,*.example.com
```

Then, run this command to obtain or renew a certificate for that domains:

```sh
docker compose run --rm certbot
```

### Backing up certificates

Run this command to get an archive of certificates and Certbot configurations
for them from the Docker volumes:

```sh
docker compose run --rm backup
```

### Restoring certificates

Run this command to store certificates and Certbot configurations for them
extracted from a backup in the Docker volumes:

```sh
docker compose run --rm restore
```

### Encrypting a backup

Before pushing a backup to your remote repository with Git, be sure to encrypt
it. First, generate a key of [age](https://github.com/FiloSottile/age):

```sh
age-keygen -o key.txt
```

Keep this key in a safe place. Of course, do not push it to a remote repository.

Next, encrypt the backup with the recipient generated with that key:

```sh
./encrypt.sh age1xxx...
```

Then, an encrypted backup `certs.tar.age` is generated. This file is safe to
push to a remote repository.

**Important:** As explained below, decrypting an encrypted backup requires the
key generated above. If this key is lost and the Docker volumes is also deleted,
you will have no way to access your certificates.

### Decrypting an encrypted backup

To decrypt an encrypted backup, use the key corresponding to the recipient
specified when encrypting. Run this command to decrypt with that key:

```sh
./decrypt.sh key.txt
```

Then, a decrypted backup `certs.tar` is generated. Restoring this file with the
command described above will allow Certbot to manage the certificates again.

## License

See [LICENSE](LICENSE) for the license of this template.
