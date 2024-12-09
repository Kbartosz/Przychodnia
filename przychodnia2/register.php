<?php
include 'config.php';

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $imie = trim($_POST['name']);
    $nazwisko = trim($_POST['Nazwi']);
    $email = trim($_POST['email']);
    $haslo = trim($_POST['password']);
    $confirmHaslo = trim($_POST['confirm-password']);
    $pesel = trim($_POST['pesel']);
    $wiek = intval($_POST['Wiek']);

    // Walidacja danych
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        die("Błędny format email.");
    }
    if (!preg_match('/^\d{11}$/', $pesel)) {
        die("PESEL musi składać się z 11 cyfr.");
    }
    if ($haslo !== $confirmHaslo) {
        die("Hasła nie pasują do siebie.");
    }
    if ($wiek <= 0 || $wiek > 150) {
        die("Wiek jest nieprawidłowy.");
    }

    // Hashowanie hasła
    $hashedPassword = password_hash($haslo, PASSWORD_DEFAULT);

    try {
        $stmt = $conn->prepare("INSERT INTO pacjent (pesel, imie, nazwisko, wiek, mail, haslo) VALUES (?, ?, ?, ?, ?, ?)");
        $stmt->execute([$pesel, $imie, $nazwisko, $wiek, $email, $hashedPassword]);
        
        echo "Rejestracja zakończona sukcesem!";
    } catch (PDOException $e) {
        if ($e->getCode() === '23000') {
            die("Email lub PESEL już istnieje.");
        }
        die("Błąd bazy danych: " . $e->getMessage());
    }
}
?>
