FROM microsoft/dotnet:sdk AS build-env
WORKDIR /dotnet-demo2/dotnet-demo2/

# Copy csproj and restore as distinct layers
COPY *.csproj ./
RUN dotnet restore

# Copy everything else and build
COPY . ./
RUN dotnet publish -c Release -o out

# Build runtime image
FROM microsoft/dotnet:aspnetcore-runtime
WORKDIR /dotnet-demo2/dotnet-demo2/
COPY --from=build-env /app/out .
ENTRYPOINT ["dotnet", "dotnet-demo2.dll"]