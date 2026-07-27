"""Tests for the main FastAPI application."""

from fastapi.testclient import TestClient

from src.main import app

client = TestClient(app)


class TestRootEndpoint:
    """Tests for the root endpoint."""

    def test_root_returns_200(self) -> None:
        response = client.get("/")
        assert response.status_code == 200

    def test_root_returns_welcome_message(self) -> None:
        response = client.get("/")
        data = response.json()
        assert data["message"] == "Welcome to PythonENV-NSV"


class TestHealthEndpoint:
    """Tests for the health check endpoint."""

    def test_health_returns_200(self) -> None:
        response = client.get("/health")
        assert response.status_code == 200

    def test_health_returns_healthy_status(self) -> None:
        response = client.get("/health")
        data = response.json()
        assert data["status"] == "healthy"

    def test_health_returns_version(self) -> None:
        response = client.get("/health")
        data = response.json()
        assert data["version"] == "0.1.0"


class TestOpenAPISchema:
    """Tests for the OpenAPI schema."""

    def test_openapi_schema_available(self) -> None:
        response = client.get("/openapi.json")
        assert response.status_code == 200

    def test_openapi_schema_has_title(self) -> None:
        response = client.get("/openapi.json")
        data = response.json()
        assert data["info"]["title"] == "PythonENV-NSV"

    def test_openapi_schema_has_version(self) -> None:
        response = client.get("/openapi.json")
        data = response.json()
        assert data["info"]["version"] == "0.1.0"
