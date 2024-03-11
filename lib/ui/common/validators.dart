String? textNotBlankValidator(String? text) =>
    (text?.trim().isEmpty ?? true) ? 'Should not be blank.' : null;
