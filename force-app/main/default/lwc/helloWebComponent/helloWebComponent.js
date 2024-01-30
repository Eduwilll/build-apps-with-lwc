import { LightningElement } from "lwc";

export default class HelloWebComponent extends LightningElement {
    name = "";
    nameFamily = "";
    menssagem = "";
    currentDate = new Date().toDateString();

    get capitalizedGreeting() {
        return `Oi ${this.name.toUpperCase()} ${this.nameFamily.toUpperCase()}!`;
    }

    handleGreetingChange(event) {
        this.name = event.target.value;
    }

    handleGreetingChange2(event) {
        this.nameFamily = event.target.value;
    }

    // Function to handle the button click and show the alert
    handleShowAlert() {
        const fullName = `${this.name} ${this.nameFamily}`;
        alert(`Nome Completo: ${fullName}`);
        this.getElementsByClassName("mensagem")
    }
}