# Construisons ensemble de A à Z un cloud opensource pour le datascientist

## Objectif  

Construire une plateforme opensource multi utilisateurs pour datascientists.  
Libre service stat (VSCode, Jupyter, RStudio ...), données (postgres ...) et orchestration (road to production).
UX simple + power-users.  
Explicitation : on veut construire un cloud opensource agnostic d'un provider. Alternative : utiliser des services managés de datascience.  
Présentation du plan d'action (n étapes)

## Socle : Kubernetes  

Importance de la conteneurisation  

## Provisionner un cluster kube  

Overview des options, cloud vs on-premise, distributions ...  
`live` : provisionning d'un cluster Kubernetes managé  

## Prise en main "admin" du cluster  

### `Théorie`  
![](img/architecture.png)  
Rappel de l'architecture, de la façon de gérer un cluster Kubernetes  
### `Pratique`  
* Installation de `kubectl` (https://kubernetes.io/docs/tasks/tools/), attention au [Version skew policy](https://kubernetes.io/releases/version-skew-policy/) : respecter `+/- 1` par rapport au cluster pour éviter les problèmes. Le mettre dans le `PATH`.  
* Téléchargement du `kubeconfig` depuis l'interface du provider (ou récupération en fonction de la distribution), le placer dans `~/.kube/config`  
* Confirmer avec `kubectl get nodes` la présence des noeuds  

## Datascience 101 : déploiement d'un service  
### `Théorie`  
Approche brute, technique, non multi-users  
### `Pratique`  
* Déploiement d'un jupyter notebook basique. `kubectl apply -f manifests/jupyter-basique`  
* `kubectl get pods` pour suivre la création du pod  
* `kubectl logs podname` une fois `Running` pour consulter les logs et récupérer le token d'accès (on ne l'a pas précisé donc il est généré dynamiquement à chaque lancement)  
* `kubectl port-forward podname 8888:8888` pour ouvrir un tunnel entre `localhost:8888` et le port 8888 du Jupyter  
* Accès et utilisation du Jupyter via `localhost:8888`  

Superbe infra datascience :thumbsup:

## Packaging, reproductibilité et configuration : Helm

### `Théorie`  
Intérêt du packaging, principes de Helm  
### `Pratique`
Désinstallation et réinstallation du service précédent  
* `kubectl delete -f manifests/jupyter-basique` pour nettoyer le service précédent  
* Recherche d'un `chart` Helm pour jupyterlab ...  
* https://artifacthub.io/packages/helm/dsri-helm-charts/jupyterlab  
```
helm repo add dsri https://maastrichtu-ids.github.io/dsri-helm-charts/
helm repo update  
helm install jupyterlab dsri/jupyterlab \
  --set storage.enabled=false \
  --set serviceAccount.name=default \
  --set service.openshiftRoute.enabled=false \
  --set password=changeme
```  
* Bonne pratique : Utiliser `helm template` AVANT d'installer pour contrôler ce qui va être installé. (à défaut, `helm get manifest <releasename>` pour voir les manifests après installation)
* Bonne pratique : Externaliser les values dans un `values.yaml` (`helm install -f values.yaml`)  

## Exposition des services vers l'extérieur

### `Théorie`  
Enjeux d'un reverse proxy  

### `Pratique`  

* `cd manifests/ingress-nginx`, `helm dependencies build` pour télécharger les dépendances (`helm dependencies update` pour les mettre à jour)  
* `helm template ingress-nginx . -f values.yaml` pour prévisualisation
* `helm install ingress-nginx . -f values.yaml` pour l'installation  
* `kubectl get pods` pour suivre l'avancée des pods, `kubectl get service` pour suivre l'affectation de l'IP loadbalancer  
* Récupérer l'IP externe (après affectation par le cloud provider)

### `Théorie`  
Rappels DNS / HTTPS  
### `Pratique`  
* Configuration d'un champ DNS `A` `*.devoxx.insee.io` => `ipexterne`.
* TODO : certificat  
* Accéder au jupyter notebook

## Bilan d'étape  

On a un cluster, accessible aux admins avec possibilité de déployer des services de façon technique.  
**Nécessité d'industrialisation et de proposer une UX**  

## Introduction d'onyxia  

Intérêt, fonctionnement  
`live` : Installation d'onyxia "brut", utilisation  

## Multi users : authentification  

Rappels OIDC, présentation de keycloak  
`live` : Installation et paramétrage de keycloak, onyxia avec authentification  


