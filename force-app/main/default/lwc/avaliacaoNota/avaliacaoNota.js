import { LightningElement, api } from "lwc";
import getUserDetails from "@salesforce/apex/avaliacaoController.getUserDetails";
import criarAvaliacao from "@salesforce/apex/avaliacaoController.criarAvaliacao";
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import Id from "@salesforce/user/Id";

export default class AvaliacaoNota extends LightningElement {
  userId = Id;
  userName;

  @api recordId;
  titulo;
  titleValue;
  nota;
  notaValue;
  descricao;
  descricaoValue;
  isButtonDisabled = false;

  get options() {
    return [
      { label: "1", value: "1" },
      { label: "2", value: "2" },
      { label: "3", value: "3" },
      { label: "4", value: "4" },
      { label: "5", value: "5" },
    ];
  }

  connectedCallback() {
    this.retrieveUserDetails();
    console.log("Record ID:", this.recordId);
  }

  retrieveUserDetails() {
    getUserDetails({ userId: this.userId })
      .then((result) => {
        this.userName = result;
      })
      .catch((error) => {
        console.error("Error fetching user details:", error);
      });
  }

  // get value
  recordChangeVal(event) {
    console.log(event.target.name);
    console.log(event.target.value);
    const field = event.target.name;
    if (field) {
      this[field] = event.target.value;
    }
  }

  handleReset() {
    // Limpar os campos após o sucesso
    //this.template.querySelector('form').reset();
    this.template
      .querySelectorAll("lightning-combobox,lightning-input,lightning-textarea")
      .forEach((each) => {
        each.value = undefined;
      });
    this.titulo = null;
    this.descricao = null;
    this.nota = null;
  }
  async handleClick() {
    if (
      this.nota === null ||
      this.nota === undefined ||
      this.titulo === null ||
      this.titulo === undefined
    ) {
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Sucesso",
          message: "Por favor, insira um valor para a nota.",
          variant: "error",
        })
      );
      // Checa se os campos com required estão preenchidos e enviar uma mensagem custom.
      let fieldErrorMsg = "Por favor insira o";
      this.template
        .querySelectorAll('[data-element="required"]')
        .forEach((item) => {
          let fieldValue = item.value;
          let fieldLabel = item.label;

          if (!fieldValue) {
            item.setCustomValidity(fieldErrorMsg + " " + fieldLabel);
          } else {
            item.setCustomValidity("");
          }
          item.reportValidity();
        });
      return;
    }
    try {
      this.isButtonDisabled = true;
      const result = await criarAvaliacao({
        titulo: this.titulo,
        descricao: this.descricao,
        nota: this.nota,
        accountId: this.recordId,
      })
        .then((result) => {
          if (result) {
            const childComponent = this.template.querySelector("c-avaliacao-lista");
            if (childComponent) {
              childComponent.refreshTable();
            }
          }
          // Exibir uma mensagem de sucesso
          this.dispatchEvent(
            new ShowToastEvent({
              title: "Sucesso",
              message: "Avaliação criada com sucesso!",
              variant: "success",
            })
          );
        })
        .catch((error) => {
          this.showToastMethods("UPS!", error.body.message, "Error");
        })
        .finally(() => {
          this.handleReset();
          this.isButtonDisabled = false;
        });
      // You can use 'result' here or perform any other actions after the promise resolves.
      
    } catch (error) {
      console.error(error);

      // Extrair a mensagem de erro da exceção
      // Check for a specific error code
      if (
        error.body &&
        error.body.message &&
        error.body.message.includes("CANNOT_INSERT_UPDATE_ACTIVATE_ENTITY")
      ) {
        // Handle the specific error related to the trigger
        errorMessage = "A custom error message for the trigger-related issue.";
      } else {
        // Handle other errors
        errorMessage = "Ocorreu um erro ao criar a avaliação.";
        if (error.body && error.body.message) {
          errorMessage += " " + error.body.message;
        }
      }

      // Exibir uma mensagem de erro
      this.dispatchEvent(
        new ShowToastEvent({
          title: "Erro",
          message: "Ocorreu um erro ao criar a avaliação." + errorMessage,
          variant: "error",
        })
      );

      this.handleReset();
    }
  }
}
