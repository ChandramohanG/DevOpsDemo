FROM microsoft/dotnet:2.1-sdk
 
WORKDIR /aspnetapp
 
COPY . .
 
RUN dotnet restore ./aspnetapp.csproj
 
RUN dotnet tool install --global dotnet-sonarscanner

RUN export PATH="$PATH:/root/.dotnet/tools"  

RUN dotnet sonarscanner begin /k:"ChandramohanG_DevOpsDemo" /d:sonar.organization="chandramohang-github" /d:sonar.host.url="https://sonarcloud.io/"

RUN dotnet build ./aspnetcore.sln

RUN dotnet sonarscanner end

RUN dotnet publish ./aspnetapp.csproj -o /publish/

WORKDIR /publish

EXPOSE 8090

ENTRYPOINT ["dotnet", "aspnetapp.dll"]
