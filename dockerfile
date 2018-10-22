FROM microsoft/dotnet
 
WORKDIR /aspnetapp
 
COPY . .
 
RUN dotnet restore
 
RUN dotnet publish ./aspnetapp.csproj -o /publish/
 
WORKDIR /publish

EXPOSE 8090

ENTRYPOINT ["dotnet", "aspnetapp.dll"]