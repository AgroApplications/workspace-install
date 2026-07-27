"""FastAPI application entry point."""

from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI(
    title="PythonENV-NSV",
    description="CursorTemplate - Python 3.12 Development Environment",
    version="0.1.0",
)


class HealthResponse(BaseModel):
    """Health check response model."""

    status: str
    version: str


class MessageResponse(BaseModel):
    """Generic message response model."""

    message: str


@app.get("/", response_model=MessageResponse)
async def root() -> MessageResponse:
    """Root endpoint returning welcome message."""
    return MessageResponse(message="Welcome to PythonENV-NSV")


@app.get("/health", response_model=HealthResponse)
async def health_check() -> HealthResponse:
    """Health check endpoint."""
    return HealthResponse(status="healthy", version="0.1.0")
