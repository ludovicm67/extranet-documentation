# Comment installer le projet ?

## Partie backend

Cette partie a été réalisé avec Laravel (https://laravel.com/).

Ce site nécessite une version de PHP supérieure ou égale à 7.1.3

Tout d'abord, clôner le dépôt et rendez-vous dans le dossier du projet.

Copier ensuite le fichier `config.example.yml` en `config.yml` et ajouter
autant d'entrées que de domaines, configurer les noms, l'url de fallback, etc...

Copier ensuite le fichier `.env.example` en `.env`. Contrairement aux
installations classiques de Laravel, ce fichier ne sera pas spécialement
utilisé, étant donné que toute la partie configuration multi-domaines se fait
dans le fichier `config.yml`, les clés intéressantes à changer dans ce fichier
sont les deux suivantes, dans le cas où l'on souhaiterait passer l'application
en production :

  - `APP_ENV`: passer la valeur à `production`

  - `APP_DEBUG`: passer la valeur à `false`



Installer ensuite les dépendences, avec un simple coup de `composer install`.

Générez ensuite les clés secrètes nécessaires à l'application, en lançant
les commandes suivantes :

```sh
php artisan key:generate --force
php artisan jwt:secret --force
```

et lancer la commande suivante pour chacun des domaines configuré dans le
fichier `config.yml`, en remplaçant `DOMAIN` par le domaine, pour lancer les
différentes migrations :

```sh
php artisan migrate --database=DOMAIN --force
```

Si la commande ci-dessus échoue, en général il suffit de la relancer une seconde
pour que ça fonctionne.

Si la base de données était vide avant le lancement des migrations, un compte
administrateur sera créé automatiquement. Les identifiants sont les suivants :

  - adresse mail : admin@example.com

  - mot de passe : admin

Pensez à supprimer ce compte une fois, ou en tout cas à en changer les
identifiants et le nom, pour des raisons de sécurité évidentes.

Pour lancer le site **en local**, un simple coup de `php artisan serve` lancera
un serveur de développement sur http://localhost:8000; s'il n'y a pas de domaine
`localhost` configuré dans le fichier `config.yml`, il faudra juste penser
à ajouter une entrée dans le fichier hosts du système, et accéder à l'un des
domaines configurés sur le port 8000.

Cependant, si il y a besoin d'accéder au site via son IP locale depuis d'autres
appareils, comme par un mobile ou un autre PC par exemple, il faudra lancer
le serveur de développement avec `php artisan serve --host 0.0.0.0`.

Lors du déploiement du site en production, il faudra configurer nginx ou Apache
pour servir le dossier `public` uniquement, et il faut servir l'API avec le
sous-domaine `api`, afin que la partie frontend sache où taper.

Il est possible de mettre à jour les données en provenance de Sellsy
automatiquement avec l'aide de tâches cron, qui appelent régulièrement les pages
suivantes :

  - `/cron/sellsy_clients`, pour mettre à jour les clients Sellsy,

  - `/cron/sellsy_contacts`, pour mettre à jour les contacts Sellsy,

  - `/cron/sellsy_orders`, pour mettre à jour les commandes Sellsy,

  - `/cron/sellsy_invoices`, pour mettre à jour les factures Sellsy.


## Partie frontend

Partie réalisée avec les technologies principales suivantes :

 - NodeJS : https://nodejs.org/

 - ReactJS : https://reactjs.org/

 - MaterialUI : https://material-ui.com/


Il est préférable d'être en possession des dernières versions de `node` et `npm`.

### Pour travailler en local

```sh
npm install
npm start
```

Ouvrir le navigateur sur http://localhost:3000 et à chaque fois qu'un
fichier sera sauvegardé, la page se mettra automatiquement à jour sans avoir
à actualiser la page à chaque fois; c'est plutôt sympa :p

Note : remplacer le domaine `localhost` par un des domaines configuré dans le
fichier `config.yml` de la partie backend, car sinon le frontend ne sera pas
en mesure de communiquer avec l'API.


### Pour avoir une version buildée pour la prod'

```sh
npm install
npm run build
```

et servir statiquement le dossier `build`.

