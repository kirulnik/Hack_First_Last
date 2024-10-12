<?php
$link = mysqli_connect('127.0.0.1', 'root', 'admin', 'restaurant1');

if (!$link) {
    die("Connection failed: " . mysqli_connect_error());
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $fullName = mysqli_real_escape_string($link, $_POST['fullName']);
    $address = mysqli_real_escape_string($link, $_POST['address']);

    $sql = "INSERT INTO `order` (FIO_order, Address) VALUES ('$fullName', '$address')";

    if (mysqli_query($link, $sql)) {
        echo "Заказ успешно принят.";
    } else {
        echo "Ошибка: " . $sql . "<br>" . mysqli_error($link);
    }

    mysqli_close($link);
}
?>
