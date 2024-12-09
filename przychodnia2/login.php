<?php
include 'config.php';

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $email = trim($_POST['email']);
    $haslo = trim($_POST['password']);

    // Sprawdzenie poprawności danych
    try {
        $stmt = $conn->prepare("SELECT * FROM pacjent WHERE email = ?");
        $stmt->execute([$email]);
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($user && password_verify($haslo, $user['haslo'])) {
            session_start();
            $_SESSION['user'] = $user['imie'] . " " . $user['nazwisko'];
            echo "Zalogowano pomyślnie!";
        } else {
            echo "Nieprawidłowy email lub hasło.";
        }
    } catch (PDOException $e) {
        die("Błąd bazy danych: " . $e->getMessage());
    }
}
?>
