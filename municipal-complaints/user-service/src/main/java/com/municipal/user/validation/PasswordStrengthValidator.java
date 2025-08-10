package com.municipal.user.validation;

import jakarta.validation.ConstraintValidator;
import jakarta.validation.ConstraintValidatorContext;

public class PasswordStrengthValidator implements ConstraintValidator<PasswordStrength, String> {
    @Override
    public boolean isValid(String value, ConstraintValidatorContext context) {
        if (value == null) return false;
        boolean hasUpper = value.matches(".*[A-Z].*");
        boolean hasLower = value.matches(".*[a-z].*");
        boolean hasDigit = value.matches(".*[0-9].*");
        return value.length() >= 8 && hasUpper && hasLower && hasDigit;
    }
}