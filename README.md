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

Rappel de l'architecture, de la façon de gérer un cluster Kubernetes
`live` : Installation de `kubectl`, téléchargement du `kubeconfig`, `kubectl get nodes`  

## Datascience 101 : déploiement d'un service  

Approche brute, technique, non multi-users  
`live` : Déploiement d'un `jupyter` à partir de contrats kube préparés. `kubectl port-forward` pour y accéder  

## Packaging, reproductibilité et configuration : Helm

Intérêt du packaging, principes de Helm  
`live` :  Désinstallation et réinstallation du service précédent

## Exposition des services vers l'extérieur

Enjeux d'un reverse proxy
`live` : Installation de `nginx-ingress` via un `values.yaml`. Accès via l'IP / URL loadbalancer.  
Rappels DNS / HTTPS  
`live` : Configuration d'un DNS `*` et certificat correspondant, accès au jupyter.  

## Bilan d'étape  

On a un cluster, accessible aux admins avec possibilité de déployer des services de façon technique.  
**Nécessité d'industrialisation et de proposer une UX**  

## Introduction d'onyxia  

Intérêt, fonctionnement  
`live` : Installation d'onyxia "brut", utilisation  

## Multi users : authentification  

Rappels OIDC, présentation de keycloak  
`live` : Installation et paramétrage de keycloak, onyxia avec authentification  


