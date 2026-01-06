from disease_engine import predict_diseases_and_recommendations

sample_data = {
    "age": 50,
    "bmi": 31,
    "sugar": 210,
    "systolic_bp": 150,
    "diastolic_bp": 95,
    "cholesterol": 260
}

result = predict_diseases_and_recommendations(sample_data)
print(result)
