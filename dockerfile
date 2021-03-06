FROM microsoft/dotnet:2.1-sdk as build-image

ENV SONAR_SCANNER_OPTS="-Xmx512m"
ENV SONAR_URL="https://sonarcloud.io/"
ENV SONAR_TOKEN="145293828abc302c83177b5d2f528f056b2eabf7"
ENV SONAR_PROJECT_KEY="ChandramohanG_DevOpsDemo"

RUN apt-get update && apt-get install -y openjdk-8-jre

WORKDIR /aspnetapp

COPY . .

RUN dotnet restore  ./aspnetapp.csproj

COPY . .

ENV PATH="${PATH}:/root/.dotnet/tools"

RUN dotnet tool install --global dotnet-sonarscanner --version 4.3.1

RUN dotnet sonarscanner begin /k:${SONAR_PROJECT_KEY} /d:sonar.organization="chandramohang-github" /d:sonar.host.url=${SONAR_URL} /d:sonar.login=${SONAR_TOKEN} /d:sonar.verbose=true /d:sonar.coverage.exclusions="*.css"
RUN dotnet publish ./aspnetapp.csproj -o /publish/
RUN dotnet sonarscanner end /d:sonar.login=${SONAR_TOKEN}

FROM microsoft/dotnet

WORKDIR /publish

COPY --from=build-image /publish .

EXPOSE 8090

ENTRYPOINT ["dotnet", "aspnetapp.dll"]
