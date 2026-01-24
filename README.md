# proxmox-backup-client-k8s

PBS-C, in k8s

## Example k8s CronJob

```yaml
---
apiVersion: batch/v1
kind: CronJob
metadata:
  name: backup-files-to-pbs
  namespace: my-namespace
spec:
  concurrencyPolicy: Forbid
  schedule: "0 2 * * *"
  jobTemplate:
    spec:
      template:
        spec:
          hostname: files
          containers:
          - name: proxmox-backup-client-k8s
            image: ghcr.io/thegooscloud/proxmox-backup-client-k8s:latest
            imagePullPolicy: Always
            command:
            - /bin/sh
            args:
            - -c
            - |
              proxmox-backup-client \
                backup \
                files.pxar:/files \
                --backup-id files \
                --backup-type host \
                --all-file-systems \
                --ns "${PBS_NS}" \
                --keyfile /files.key \
                --skip-lost-and-found \
                --change-detection-mode metadata
            env:
            - name: PBS_REPOSITORY
              value: "files@pbs@pbs:8007:backups"
            - name: PBS_NS
              value: "files"
            - name: PBS_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: pbs-secret-files
                  key: PBS_PASSWORD
            volumeMounts:
            - mountPath: "/files"
              name: files
            - mountPath: "/files.key"
              name: files-key
              subPath: files.key
          restartPolicy: OnFailure
          volumes:
          - name: photos
            persistentVolumeClaim:
              claimName: files
          - name: files-key
            secret:
              secretName: pbs-key-files
```
