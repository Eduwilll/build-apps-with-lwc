import { LightningElement, track } from 'lwc';

export default class Idade_tarde extends LightningElement {

    @track num1 = null;
    @track num2 = null;
    @track result = null;

    handleNum1Change(event){
        this.num1 = event.target.value;
    }
    handleNum2Change(event){
        this.num2 = event.target.value;
    }

    handleAdd(){
        this.result = parseFloat(this.num1) +  parseFloat(this.num2);
    }
    handleSubtract(){
        this.result = this.num1 - this.num2;
    }
    handleMultiply(){
        this.result = this.num1 * this.num2;
    }
    handleDivide(){
        if (this.num2 !== 0) {
            this.result = this.num1 / this.num2;
        } else {
            alert('Não possivel fazer divisão por zero')

        }
    }
}