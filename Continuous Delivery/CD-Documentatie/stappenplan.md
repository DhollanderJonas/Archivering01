1. Clone de github repo (DhollanderJonas/Archivering01)
2. Cd continuous delivery -> cd CDFinal
3. `vagrant up`
4. Wacht tot ansible klaar is met provisioning
5. Surf naar [10.100.198.200:8080](10.100.198.200:8080) -> Jenkins homescreen
6. In Jenkins -> start Jenkins job todobackend met wachtwoord “dudusolutions”
7. `vagrant ssh cd`
8. `cd \vagrant`
9. `docker compose up`
10. Surf naar 10.100.198.200:3000 -> client screen van de app.
11. Deployment process niet opgenomen in pipeline omdat we voor continuous delivery, niet continuous deployment hebben gewerkt



