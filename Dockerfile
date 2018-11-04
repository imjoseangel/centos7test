FROM centos:7
LABEL maintainer="imjoseangel"

ARG username=ansible
ARG password=ansible
ARG publickey="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDj6pQjakenUVocXKC3ei7FYTSgB3EpWAdhs39vj8mATo8HsV4zvIdskJFiyswdqNyl1pZ86fr0YoaOJbLoBOH76W8oWUhVhXehBueapK/Q5OLtDwDs3BfcpCeNjHUUP97gpOltFTm7c3E81Zi9TQgjn5+sXzsYQ/f1uI+ikCDFHRJCW8WK8TLOSpSq4iIyv89G+OvOpXagqhKeHGcSCXfT8EPKiVUstn/um5DftVXjHKnLx+2jhb0b6xF+NA7Zk1NoSN0AZZ6NYP7EzvwP/Ao+2qslso7XXUWziE4Ni0+CBEgqQ11ak1f9ocONJYvLRCFcGaZLWtlVARQjd2iK8EKoHeoSAwGQaxnfTXa0StZD/IQd+jg+lii75V768X468wndR85cHlauoGeI/mbgcILSc2lUYIFW08rE+wkqEGg3AtIuaiptLOpoZnoWweL4ZR1l5daw7DkpmZDdDU8Ee2xLqXmr5x8RB4rmaYRyhW5rwYSpGACcQDNozAVCtyEQ1bxL+dNB8WL5LK2weaokqYnza3NA/O+rQCyxa0IqnozW4Jw/3pOLXpJMQPQSJlzem8ZHoZAKOnQgc5a4jQ88otAve7gN2ViTET6DE7pIXpqBUi/gCMyUo9Ji87ItIKneYtYlpCHQb6M7ihdwln0hlex06cciQen7YlKBrgMpfkEk4w=="


RUN rm -f /etc/localtime && ln -s /usr/share/zoneinfo/UTC /etc/localtime
RUN yum upgrade -y
RUN yum clean all
RUN yum install -y sudo openssh-server openssh-clients which curl htop
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key
RUN mkdir -p /var/run/sshd

RUN useradd -d /home/${username} -m -s /bin/bash -G wheel ${username}
RUN echo "${username}:${password}" | chpasswd
RUN echo "${username} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN mkdir -p /home/${username}/.ssh
RUN chown -R ${username} /home/${username}/.ssh
RUN chmod 0700 /home/${username}/.ssh
RUN touch /home/${username}/.ssh/authorized_keys
RUN chown ${username} /home/${username}/.ssh/authorized_keys
RUN chmod 0600 /home/${username}/.ssh/authorized_keys
RUN echo $publickey >> /home/${username}/.ssh/authorized_keys

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
