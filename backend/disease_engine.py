def predict_diseases_and_recommendations(data):
    age = data["age"]
    bmi = data["bmi"]
    sugar = data["sugar"]
    sys_bp = data["systolic_bp"]
    dia_bp = data["diastolic_bp"]
    cholesterol = data["cholesterol"]

    diseases = {}
    recommendations = []

    # ---------------- Diabetes ----------------
    if sugar < 140:
        diseases["Diabetes"] = "Low"
    elif sugar < 200:
        diseases["Diabetes"] = "Medium"
        recommendations.append("Reduce sugar and refined carbohydrates")
    else:
        diseases["Diabetes"] = "High"
        recommendations.extend([
            "Strict low-sugar diet",
            "Walk 30–45 minutes daily",
            "Blood sugar check every 3 months"
        ])

    # ---------------- Hypertension ----------------
    if sys_bp < 120 and dia_bp < 80:
        diseases["Hypertension"] = "Low"
    elif sys_bp < 140 or dia_bp < 90:
        diseases["Hypertension"] = "Medium"
        recommendations.extend([
            "Reduce salt intake",
            "Monitor BP every month"
        ])
    else:
        diseases["Hypertension"] = "High"
        recommendations.extend([
            "Low-sodium diet",
            "Daily BP monitoring",
            "Consult doctor for BP management"
        ])

    # ---------------- Obesity Status (BMI-based) ----------------
    if bmi < 25:
        diseases["Obesity Status (BMI)"] = "Normal"
    elif bmi < 30:
        diseases["Obesity Status (BMI)"] = "Overweight"
        recommendations.extend([
            "Increase physical activity",
            "Avoid junk and fried foods"
        ])
    else:
        diseases["Obesity Status (BMI)"] = "Obese"
        recommendations.extend([
            "Weight reduction diet",
            "45 minutes walking or exercise daily",
            "Regular weight monitoring"
        ])

    # ---------------- Obesity Risk (Metabolic – No BMI) ----------------
    metabolic_risk_count = 0
    if sugar >= 140:
        metabolic_risk_count += 1
    if sys_bp >= 140 or dia_bp >= 90:
        metabolic_risk_count += 1
    if cholesterol >= 240:
        metabolic_risk_count += 1
    if age >= 45:
        metabolic_risk_count += 1

    if metabolic_risk_count <= 1:
        diseases["Obesity Risk (Metabolic)"] = "Low"
    elif metabolic_risk_count == 2:
        diseases["Obesity Risk (Metabolic)"] = "Medium"
        recommendations.append("Lifestyle modification to prevent metabolic obesity")
    else:
        diseases["Obesity Risk (Metabolic)"] = "High"
        recommendations.extend([
            "Comprehensive lifestyle intervention recommended",
            "Monitor metabolic parameters regularly",
            "Preventive obesity counseling advised"
        ])

    # ---------------- Heart Disease ----------------
    heart_risk_factors = 0
    if age >= 45:
        heart_risk_factors += 1
    if sys_bp >= 140:
        heart_risk_factors += 1
    if cholesterol >= 240:
        heart_risk_factors += 1

    if heart_risk_factors == 0:
        diseases["Heart Disease"] = "Low"
    elif heart_risk_factors == 1:
        diseases["Heart Disease"] = "Medium"
        recommendations.append("Annual heart health screening")
    else:
        diseases["Heart Disease"] = "High"
        recommendations.extend([
            "Heart-friendly diet",
            "Avoid smoking and alcohol",
            "ECG and cardiac consultation recommended"
        ])

    # Remove duplicate recommendations
    recommendations = list(set(recommendations))

    return {
        "diseases": diseases,
        "recommendations": recommendations
    }
