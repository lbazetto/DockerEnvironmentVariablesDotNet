FROM mcr.microsoft.com/dotnet/aspnet:5.0-alpine AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:5.0 AS build
WORKDIR /src
COPY ["DockerSettingsEnvVariables.csproj", "./"]
RUN dotnet restore "DockerSettingsEnvVariables.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "DockerSettingsEnvVariables.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "DockerSettingsEnvVariables.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "DockerSettingsEnvVariables.dll"]
