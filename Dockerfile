FROM alpine

# Downloads
RUN mkdir /usr/downloads

RUN apk add --no-cache git

ADD https://releases.hashicorp.com/terraform/0.14.3/terraform_0.14.3_linux_amd64.zip /usr/downloads
ADD https://github.com/gruntwork-io/terragrunt/releases/download/v0.26.7/terragrunt_linux_amd64 /usr/downloads
ADD https://github.com/gruntwork-io/terratest/releases/download/v0.31.2/pick-instance-type_linux_amd64 /usr/downloads
ADD https://github.com/cloudskiff/driftctl/releases/download/v0.1.1/driftctl_linux_amd64 /usr/downloads

RUN unzip /usr/downloads/terraform*.zip \
    && mv terraform /usr/local/bin

RUN cd /usr/downloads \
    && mv terragrunt_linux_amd64 terragrunt \
    && mv terragrunt /usr/local/bin/terragrunt \
    && chmod +x /usr/local/bin/terragrunt

RUN cd /usr/downloads \
    && mv pick-instance-type_linux_amd64 terratest \
    && mv terratest /usr/local/bin/terratest \
    && chmod +x /usr/local/bin/terratest

RUN cd /usr/downloads \
    && mv driftctl_linux_amd64 driftctl \
    && mv driftctl /usr/local/bin/driftctl \
    && chmod +x /usr/local/bin/driftctl    

RUN cd / \
    && mkdir source \
    && git clone https://github.com/bytejunkie/terraform-azurerm-resource-group /source/terraform-azurerm-resource-group