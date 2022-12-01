FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /app_build

COPY *.csproj ./
RUN dotnet restore

COPY ./ ./

RUN dotnet publish -c Release -o build_out

FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app

COPY --from=build-env /app_build/build_out ./

ENTRYPOINT ["dotnet", "UserMicroservice.dll"]