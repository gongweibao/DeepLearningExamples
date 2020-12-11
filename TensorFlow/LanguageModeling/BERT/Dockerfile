ARG FROM_IMAGE_NAME=nvcr.io/nvidia/tensorflow:20.06-tf1-py3

FROM ${FROM_IMAGE_NAME}

RUN apt-get update && apt-get install -y pbzip2 pv bzip2 libcurl4 curl libb64-dev
RUN pip install --upgrade pip
RUN pip install toposort networkx pytest nltk tqdm html2text progressbar
RUN pip --no-cache-dir --no-cache install git+https://github.com/NVIDIA/dllogger wget

WORKDIR /root/tensorflow
RUN git clone https://github.com/openai/gradient-checkpointing.git
RUN git clone https://github.com/attardi/wikiextractor.git && cd wikiextractor && git checkout 6408a430fc504a38b04d37ce5e7fc740191dee16 && cd ..
RUN git clone https://github.com/soskek/bookcorpus.git
RUN git clone https://github.com/titipata/pubmed_parser


RUN pip3 install /root/tensorflow/pubmed_parser

#Copy the perf_client over
ARG TRTIS_CLIENTS_URL=https://github.com/NVIDIA/triton-inference-server/releases/download/v2.2.0/v2.2.0_ubuntu1804.clients.tar.gz
RUN mkdir -p /root/tensorflow/install \
    && curl -L ${TRTIS_CLIENTS_URL} | tar xvz -C /root/tensorflow/install

#Install the python wheel with pip
RUN pip install /root/tensorflow/install/python/triton*.whl

WORKDIR /root/tensorflow/bert
COPY . .

ENV PYTHONPATH /root/tensorflow/bert
ENV BERT_PREP_WORKING_DIR /root/tensorflow/bert/data
ENV PATH //root/tensorflow/install/bin:${PATH}
ENV LD_LIBRARY_PATH /root/tensorflow/install/lib:${LD_LIBRARY_PATH}
