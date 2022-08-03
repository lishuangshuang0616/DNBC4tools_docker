FROM continuumio/miniconda3

MAINTAINER lishuangshuang <lishuangshuang3@mgi-tech.com>

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV HOME /home/DNBC4tools
ENV XDG_CONFIG_HOME /home/DNBC4tools

RUN mkdir /home/DNBC4tools
WORKDIR /home/DNBC4tools

RUN conda update -q -y conda
RUN conda install -q -y wget
RUN wget https://raw.githubusercontent.com/lishuangshuang0616/DNBC4tools_docker/main/DNBC4tools.yaml
RUN conda env create -f DNBC4tools.yaml -n DNBC4tools

RUN rm DNBC4tools.yaml
RUN /bin/bash -c "source activate DNBC4tools"
RUN echo "source activate DNBC4tools" >> $HOME/.bashrc

ENV PATH /opt/conda/envs/DNBC4tools/bin:$PATH
ENV LD_LIBRARY_PATH /opt/conda/envs/DNBC4tools/lib:$LD_LIBRARY_PATH

RUN pip install dnbc4tools==2.0.3
RUN pip install polars==0.13.40
RUN pip install tarjan==0.2.3.2

RUN R -e "devtools::install_github(c('chris-mcginnis-ucsf/DoubletFinder','ggjlab/scHCL','ggjlab/scMCA'),force = TRUE);"

VOLUME ["/data","/database"]
WORKDIR /data
