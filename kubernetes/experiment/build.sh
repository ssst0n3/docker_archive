# docker buildx create --name insecure-builder --buildkitd-flags "--allow-insecure-entitlement security.insecure"
docker buildx build --progress=plain --builder insecure-builder --allow security.insecure .
