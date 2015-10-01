docker-fluent
=============

This is a small image based on Alpine taht allows launching fluentd with custom configuration.

To launch it use `docker run <options> -v <config_dir>:/etc/fluent gobby/fluent`

## Use examples

### Example collector config

<config_dir>/fluent.conf

    <source>
      type secure_forward
      secure true
      shared_key some_secret
      self_hostname logs.domain.tld
      ca_cert_path /etc/fluent/ca_cert.pem
      ca_private_key_path /etc/fluent/ca_key.pem
      ca_private_key_passphrase some_passphrase
    </source>

    <match **>
      type stdout
    </match>

<config_dir>/ca_key.pem - private key
<config_dir>/ca_cert.pem - certificate

### Example sender config

<config_dir>/fluent.conf

    <source>
      type named_pipe
      format apache2
      tag varnish
      path /var/run/fluent.fifo
    </source>
    
    <match **>
      type secure_forward
      secure true
      ca_cert_path /etc/fluent/ca_cert.pem
      self_hostname "#{ENV['HOSTNAME']}"
      shared_key some_secret
      flush_interval 5s

      <server>
        host logs.domain.tld
      </server>
    </match>

<config_dir>/ca_cert.pem - certificate

