FROM microsoft/dotnet
 
WORKDIR /aspnetapp
 
COPY . .
 
RUN dotnet restore ./aspnetapp.csproj
 
RUN dotnet publish ./aspnetapp.csproj -o /publish/

dotnet tool install --global dotnet-sonarscanner

export PATH="$PATH:/root/.dotnet/tools"  

RUN dotnet sonarscanner begin /k:"ChandramohanG_DevOpsDemo" /d:sonar.organization="chandramohang-github" /d:sonar.host.url="https://sonarcloud.io/" /d:sonar.coverage.exclusions="*.css"

RUN dotnet build ./aspnetcore.sln

RUN dotnet sonarscanner end

WORKDIR /publish

EXPOSE 8090

ENTRYPOINT ["dotnet", "aspnetapp.dll"]
