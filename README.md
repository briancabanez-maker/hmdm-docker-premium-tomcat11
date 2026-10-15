# Headwind MDM Premium 7.x on Docker (Tomcat 11 + Java 17) - unofficial

Unofficial Dockerfile that runs the Headwind MDM Premium 7.03.1 web panel on top of the official `headwindmdm/hmdm:0.1.8` image, replacing Tomcat 9 / Java 11 with Tomcat 11 / Java 17. It is a stopgap until Headwind publishes an official image. Not affiliated with Headwind.

**This repository does not contain the Premium WAR or the `lib/` jars.** You need the Premium installer package from Headwind (a trial is available at https://h-mdm.com/contact-us/).

## Status
- Tested: the container starts, a Community 5.39.2 database is migrated by Liquibase, the trial license is accepted, previously enrolled devices reconnect.
- Not tested: HTTPS, MQTT push, the Premium plugins, upgrades, other versions.
- Observed: with `PROTOCOL=http` the log shows a SEVERE about `/usr/local/tomcat/ssl/hmdm.jks` (HTTPS connector). It did not prevent startup.

## Build (works without internet once the base image and files are local)
Put these files next to the Dockerfile:
- `jdk17.tar.gz`: Temurin 17 JDK for Linux x64
- `tomcat11.tar.gz`: Apache Tomcat 11.0.24
- `lib/`: the `lib` folder of the Premium installer package
- `server.xml`: extracted from the official image:

    docker run --rm --entrypoint cat headwindmdm/hmdm:0.1.8 /usr/local/tomcat/conf/server.xml > server.xml

Then:

    docker build -t hmdm-premium:7.03.1 .

## Run
1. Copy the WAR from the package to `volumes/work/cache/`. Its file name must match the last part of `HMDM_URL`, so the entrypoint skips the download.
2. Write `volumes/hmdm-config/ROOT.xml` from `install/context_template.xml` of the package (7.x uses different parameters than 5.x).
3. Adapt `docker-compose.example.yaml` and start it.
4. Open the panel and enter the license key.
