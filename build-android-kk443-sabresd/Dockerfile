FROM gmacario/build-aosp

RUN mkdir -p /opt/local

ADD startup.sh /root/
RUN chmod a+x /root/startup.sh

ADD startup2.sh /home/build/
RUN chown build /home/build/startup2.sh
RUN chmod a+x /home/build/startup2.sh

#ADD local/jdk-6u45-linux-x64.bin /opt/local/
#RUN chmod a+x /opt/local/jdk-6u45-linux-x64.bin
#ADD local/android_KK4.4.3_2.0.0-ga_core_source.gz /opt/local/

#ENTRYPOINT ["/bin/bash"]
#ENTRYPOINT ""
#CMD ["/bin/bash", "-c", "/root/startup.sh"]
#CMD ["/bin/bash"]
CMD ["/root/startup.sh"]

# EOF
