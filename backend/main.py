from fastapi import FastAPI
from pydantic import BaseModel
from typing import Optional
from disease_engine import predict_diseases_and_recommendations

app = FastAPI(title="Kincare AI Backend")

# In-memory family storage (demo purpose)
family_records = {}


class PatientData(BaseModel):
    age: int
    bmi: float
    sugar: float
    systolic_bp: int
    diastolic_bp: int
    cholesterol: float
    state: Optional[str] = None
    family_id: Optional[str] = None


@app.post("/predict")
def predict(data: PatientData):
    result = predict_diseases_and_recommendations(data.dict())

    family_alert = None

    if data.family_id:
        family = family_records.get(data.family_id, [])
        family.append(result["diseases"])
        family_records[data.family_id] = family

        for disease, risk in result["diseases"].items():
            if risk == "High":
                family_alert = (
                    f"High {disease} risk detected. "
                    "Recommend screening other family members."
                )
                break

    return {
        "status": "success",
        "result": result,
        "family_alert": family_alert
    }
