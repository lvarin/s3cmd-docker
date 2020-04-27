# s3cmd cronjob template draft

This is a (Draft) templateto create a s3 cronjob. It uses [s3cmd](https://github.com/s3tools/s3cmd) as client, and creates an example cronjob that lists all the available buckets.

## Install

The process to install this template localy to the current namespace is, first add the templte to openshift (`oc create`), then fill up the file `secrets` with the access_key and the secret_key, finaly create the objects (`oc process`).

```console
oc create -f s3cmd.yaml
# oc replace -f s3cmd.yaml --force
oc process -f s3cmd.yaml --parameters
vim secrets
# oc delete cronjobs/s3cmd secrets/s3cmd-secret is/s3cmd bc/s3cmd
oc process s3cmd --param-file secrets  | oc create -f -
```

* *secrets* file:

```ini
ACCESSKEY=
SECRETKEY=
```

In order to get the values you may use the following command:

```console
source project_XXXXXXX-openrc.sh # Download it from Pouta
openstack ec2 credentials list -f yaml
```

## Test installed cronjob

With the default syntaxt, the cronjob will only run every hour at half past. In order to test it:

```console
oc create job "test-$(date +%s)" --from=cronjob/s3cmd
```

This create a job with a name like `test-1587549857`, which will create a pod. To see the output of the cronjob do a something like `oc logs -f test-1587549857-pod`.
