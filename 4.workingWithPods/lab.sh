
PS C:\Users\student\Desktop\D3.k8s-codebase> kubectl config view
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://6741ad19-9f48-4e1c-87a4-1c9744f0bd5b.us-lax-2-gw.linodelke.net:443
  name: lke665613
contexts:
- context:
    cluster: lke665613
    namespace: default
    user: lke665613-admin
  name: lke665613-ctx
current-context: lke665613-ctx
kind: Config
users:
- name: lke665613-admin
  user:
    token: REDACTED
PS C:\Users\student\Desktop\D3.k8s-codebase> kubectl get nodes
NAME                     STATUS   ROLES    AGE     VERSION
lke665613-986603-f2rbb   Ready    <none>   5m36s   v1.36.3
lke665613-986603-g5nk6   Ready    <none>   5m31s   v1.36.3
lke665613-986603-przhp   Ready    <none>   5m20s   v1.36.3
lke665613-986603-w9pgj   Ready    <none>   5m21s   v1.36.3
lke665613-986603-xsspn   Ready    <none>   5m28s   v1.36.3
PS C:\Users\student\Desktop\D3.k8s-codebase> kubectl get nodes -o wide
NAME                     STATUS   ROLES    AGE     VERSION   INTERNAL-IP       EXTERNAL-IP       OS-IMAGE                       KERNEL-VERSION                       CONTAINER-RUNTIME
lke665613-986603-f2rbb   Ready    <none>   6m2s    v1.36.3   192.168.146.10    172.235.62.48     Debian GNU/Linux 13 (trixie)   6.12.101+deb13-cloud-amd64 (amd64)   containerd://2.3.3
lke665613-986603-g5nk6   Ready    <none>   5m57s   v1.36.3   192.168.146.18    172.233.141.213   Debian GNU/Linux 13 (trixie)   6.12.101+deb13-cloud-amd64 (amd64)   containerd://2.3.3
lke665613-986603-przhp   Ready    <none>   5m46s   v1.36.3   192.168.146.14    172.233.141.79    Debian GNU/Linux 13 (trixie)   6.12.101+deb13-cloud-amd64 (amd64)   containerd://2.3.3
lke665613-986603-w9pgj   Ready    <none>   5m47s   v1.36.3   192.168.146.229   172.233.131.170   Debian GNU/Linux 13 (trixie)   6.12.101+deb13-cloud-amd64 (amd64)   containerd://2.3.3
lke665613-986603-xsspn   Ready    <none>   5m54s   v1.36.3   192.168.145.85    172.235.57.122    Debian GNU/Linux 13 (trixie)   6.12.101+deb13-cloud-amd64 (amd64)   containerd://2.3.3
PS C:\Users\student\Desktop\D3.k8s-codebase>
PS C:\Users\student\Desktop\D3.k8s-codebase> kubectl apply -f C:\Users\student\Desktop\D3.k8s-codebase\4.workingWithPods\pod.yaml
pod/hello-pod created
PS C:\Users\student\Desktop\D3.k8s-codebase> kubectl get pods
NAME        READY   STATUS    RESTARTS   AGE
hello-pod   1/1     Running   0          11s
PS C:\Users\student\Desktop\D3.k8s-codebase> kubectl get pods -o wide
NAME        READY   STATUS    RESTARTS   AGE     IP           NODE                     NOMINATED NODE   READINESS GATES
hello-pod   1/1     Running   0          4m10s   10.2.1.130   lke665613-986603-w9pgj   <none>           <none>
PS C:\Users\student\Desktop\D3.k8s-codebase> kubectl get pods -o yaml
apiVersion: v1
items:
- apiVersion: v1
  kind: Pod
  metadata:
    annotations:
      cni.projectcalico.org/containerID: 32d7db29d5198dca696196288035a899679e1b6636cef559b284755044c71640
      cni.projectcalico.org/podIP: 10.2.1.130/32
      cni.projectcalico.org/podIPs: 10.2.1.130/32
      kubectl.kubernetes.io/last-applied-configuration: |
        {"apiVersion":"v1","kind":"Pod","metadata":{"annotations":{},"labels":{"version":"v1","zone":"prod"},"name":"hello-pod","namespace":"default"},"spec":{"containers":[{"image":"nigelpoulton/k8sbook:1.0","name":"hello-ctr","ports":[{"containerPort":8080}],"resources":{"limits":{"cpu":"0.5","memory":"256Mi"}}}]}}
    creationTimestamp: "2026-10-10T06:18:13Z"
    generation: 1
    labels:
      topology.kubernetes.io/region: us-lax
      version: v1
      zone: prod
    name: hello-pod
    namespace: default
    resourceVersion: "2202"
    uid: de47241f-23c5-467f-b78d-573c2ce78d7d
  spec:
    containers:
    - image: nigelpoulton/k8sbook:1.0
      imagePullPolicy: IfNotPresent
      name: hello-ctr
      ports:
      - containerPort: 8080
        protocol: TCP
      resources:
        limits:
          cpu: 500m
          memory: 256Mi
        requests:
          cpu: 500m
          memory: 256Mi
      terminationMessagePath: /dev/termination-log
      terminationMessagePolicy: File
      volumeMounts:
      - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
        name: kube-api-access-g56hp
        readOnly: true
    dnsPolicy: ClusterFirst
    enableServiceLinks: true
    nodeName: lke665613-986603-w9pgj
    preemptionPolicy: PreemptLowerPriority
    priority: 0
    restartPolicy: Always
    schedulerName: default-scheduler
    securityContext: {}
    serviceAccount: default
    serviceAccountName: default
    terminationGracePeriodSeconds: 30
    tolerations:
    - effect: NoExecute
      key: node.kubernetes.io/not-ready
      operator: Exists
      tolerationSeconds: 300
    - effect: NoExecute
      key: node.kubernetes.io/unreachable
      operator: Exists
      tolerationSeconds: 300
    volumes:
    - name: kube-api-access-g56hp
      projected:
        defaultMode: 420
        sources:
        - serviceAccountToken:
            expirationSeconds: 3607
            path: token
        - configMap:
            items:
            - key: ca.crt
              path: ca.crt
            name: kube-root-ca.crt
        - downwardAPI:
            items:
            - fieldRef:
                apiVersion: v1
                fieldPath: metadata.namespace
              path: namespace
  status:
    allocatedResources:
      cpu: 500m
      memory: 256Mi
    conditions:
    - lastProbeTime: null
      lastTransitionTime: "2026-10-10T06:18:14Z"
      observedGeneration: 1
      status: "True"
      type: PodReadyToStartContainers
    - lastProbeTime: null
      lastTransitionTime: "2026-10-10T06:18:13Z"
      observedGeneration: 1
      status: "True"
      type: Initialized
    - lastProbeTime: null
      lastTransitionTime: "2026-10-10T06:18:20Z"
      observedGeneration: 1
      status: "True"
      type: Ready
    - lastProbeTime: null
      lastTransitionTime: "2026-10-10T06:18:20Z"
      observedGeneration: 1
      status: "True"
      type: ContainersReady
    - lastProbeTime: null
      lastTransitionTime: "2026-10-10T06:18:13Z"
      observedGeneration: 1
      status: "True"
      type: PodScheduled
    containerStatuses:
    - allocatedResources:
        cpu: 500m
        memory: 256Mi
      containerID: containerd://245801a8b08bbef6074855046e63f415b5b4ae343e742c6322b78f114948696e
      image: docker.io/nigelpoulton/k8sbook:1.0
      imageID: docker.io/nigelpoulton/k8sbook@sha256:2209995b11148d3bdf962a9364946cec57d088f831521e0a023085a741a6a1e2
      lastState: {}
      name: hello-ctr
      ready: true
      resources:
        limits:
          cpu: 500m
          memory: 256Mi
        requests:
          cpu: 500m
          memory: 256Mi
      restartCount: 0
      started: true
      state:
        running:
          startedAt: "2026-10-10T06:18:20Z"
      user:
        linux:
          gid: 0
          supplementalGroups:
          - 0
          - 1
          - 2
          - 3
          - 4
          - 6
          - 10
          - 11
          - 20
          - 26
          - 27
          uid: 0
      volumeMounts:
      - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
        name: kube-api-access-g56hp
        readOnly: true
        recursiveReadOnly: Disabled
    hostIP: 192.168.146.229
    hostIPs:
    - ip: 192.168.146.229
    - ip: 2a01:7e03::2000:c4ff:fe39:96ba
    observedGeneration: 1
    phase: Running
    podIP: 10.2.1.130
    podIPs:
    - ip: 10.2.1.130
    qosClass: Guaranteed
    resources:
      limits:
        cpu: 500m
        memory: 256Mi
      requests:
        cpu: 489m
        memory: 256Mi
    startTime: "2026-10-10T06:18:13Z"
kind: List
metadata:
  resourceVersion: ""
PS C:\Users\student\Desktop\D3.k8s-codebase>


---

PS C:\Users\student> kubectl describe pod hello-pod
Name:             hello-pod
Namespace:        default
Priority:         0
Service Account:  default
Node:             lke665613-986603-w9pgj/192.168.146.229
Start Time:       Sat, 10 Oct 2026 11:48:13 +0530
Labels:           topology.kubernetes.io/region=us-lax
                  version=v1
                  zone=prod
Annotations:      cni.projectcalico.org/containerID: 32d7db29d5198dca696196288035a899679e1b6636cef559b284755044c71640
                  cni.projectcalico.org/podIP: 10.2.1.130/32
                  cni.projectcalico.org/podIPs: 10.2.1.130/32
Status:           Running
IP:               10.2.1.130
IPs:
  IP:  10.2.1.130
Containers:
  hello-ctr:
    Container ID:   containerd://245801a8b08bbef6074855046e63f415b5b4ae343e742c6322b78f114948696e
    Image:          nigelpoulton/k8sbook:1.0
    Image ID:       docker.io/nigelpoulton/k8sbook@sha256:2209995b11148d3bdf962a9364946cec57d088f831521e0a023085a741a6a1e2
    Port:           8080/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Sat, 10 Oct 2026 11:48:20 +0530
    Ready:          True
    Restart Count:  0
    Limits:
      cpu:     500m
      memory:  256Mi
    Requests:
      cpu:        500m
      memory:     256Mi
    Environment:  <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-g56hp (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True
  Initialized                 True
  Ready                       True
  ContainersReady             True
  PodScheduled                True
Volumes:
  kube-api-access-g56hp:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    Optional:                false
    DownwardAPI:             true
QoS Class:                   Guaranteed
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  12m   default-scheduler  Successfully assigned default/hello-pod to lke665613-986603-w9pgj
  Normal  Pulling    12m   kubelet            spec.containers{hello-ctr}: Pulling image "nigelpoulton/k8sbook:1.0"
  Normal  Pulled     12m   kubelet            spec.containers{hello-ctr}: Successfully pulled image "nigelpoulton/k8sbook:1.0" in 5.774s (5.774s including waiting). Image size: 63083036 bytes.
  Normal  Created    12m   kubelet            spec.containers{hello-ctr}: Container created
  Normal  Started    12m   kubelet            spec.containers{hello-ctr}: Container started
PS C:\Users\student>

---

PS C:\Users\student> kubectl get pods
NAME        READY   STATUS    RESTARTS   AGE
hello-pod   1/1     Running   0          15m
PS C:\Users\student> kubectl exec hello-pod -- ps
PID   USER     TIME  COMMAND
    1 root      0:00 {MainThread} node ./app.js
   14 root      0:00 ps
PS C:\Users\student> kubectl exec hello-pod -- curl localhost:8080
error: Internal error occurred: Internal error occurred: error executing command in container: failed to exec in container: failed to start exec "e569ff265887c6df616546674d8c1a07da63a53f9f161ce13679b26bd90a8ee8": OCI runtime exec failed: exec failed: unable to start container process: exec: "curl": executable file not found in $PATH
PS C:\Users\student> kubectl exec -it hello-pod -- sh
/src # ls
Dockerfile         app.js             node_modules       package-lock.json  package.json       readme.md          views
/src # cat /etc/os-release
NAME="Alpine Linux"
ID=alpine
VERSION_ID=3.21.3
PRETTY_NAME="Alpine Linux v3.21"
HOME_URL="https://alpinelinux.org/"
BUG_REPORT_URL="https://gitlab.alpinelinux.org/alpine/aports/-/issues"
/src # which curl
/src # curl localhost:8080
sh: curl: not found
/src # apk install curl
ERROR: 'install' is not an apk command. See 'apk --help'.
/src # apk add curl
fetch https://dl-cdn.alpinelinux.org/alpine/v3.21/main/x86_64/APKINDEX.tar.gz
fetch https://dl-cdn.alpinelinux.org/alpine/v3.21/community/x86_64/APKINDEX.tar.gz
(1/9) Installing brotli-libs (1.1.0-r2)
(2/9) Installing c-ares (1.34.8-r0)
(3/9) Installing libunistring (1.2-r0)
(4/9) Installing libidn2 (2.3.7-r0)
(5/9) Installing nghttp2-libs (1.69.0-r0)
(6/9) Installing libpsl (0.21.5-r3)
(7/9) Installing zstd-libs (1.5.6-r2)
(8/9) Installing libcurl (8.14.1-r2)
(9/9) Installing curl (8.14.1-r2)
Executing busybox-1.37.0-r12.trigger
OK: 14 MiB in 26 packages
/src # which curl
/usr/bin/curl


PS C:\Users\student> kubectl exec hello-pod -- curl localhost:8080
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   599  100   599    0     0  20298      0 --:--:-- --:--:-- --:--:-- 20655
<html><head><title>K8s rocks</title><link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous"/></head><body><div class="container"><div class="jumbotron"><h1 style="text-align:center;">Kubernetes rocks!</h1><p style="text-align:center;">Check out my AI book.</p><p style="text-align:center;">          <a class="btn btn-primary" href="https://www.amazon.com/dp/1916585388">AI Explained: Facts, Fiction, and Future</a></p></div></div></body></html>
PS C:\Users\student>
