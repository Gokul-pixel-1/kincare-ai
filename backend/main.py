from fastapi import FastAPI
from pydantic import BaseModel
from fastapi.middleware.cors import CORSMiddleware
from disease_engine import predict_diseases_and_recommendations


app = FastAPI(title="Kincare AI Backend")


# ------------------- Allow Flutter/Web access -------------------
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


# ------------------- Input Data Model -------------------
class PatientData(BaseModel):
    age: float
    bmi: float
    sugar: float
    systolic_bp: float
    diastolic_bp: float
    cholesterol: float

    family_history_diabetes: str | None = "none"
    family_history_heart: str | None = "none"
    family_history_bp: str | None = "none"
    family_history_obesity: str | None = "none"


# ------------------- Root Check Endpoint -------------------
@app.get("/")
def root():
    return {"message": "Kincare AI Backend is running"}


# ------------------- Prediction API -------------------
@app.post("/predict")
def predict(data: PatientData):
    result = predict_diseases_and_recommendations(data.model_dump())
    return result
