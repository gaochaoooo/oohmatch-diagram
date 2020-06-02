# diagram.py
from diagrams import Cluster, Diagram

from diagrams.oci.edge import CdnGrey
from diagrams.onprem.client import Client
from diagrams.onprem.client import Users
from diagrams.programming.framework import Vue
from diagrams.programming.framework import Django
from diagrams.onprem.database import PostgreSQL
from diagrams.onprem.ci import Circleci
from diagrams.onprem.vcs import Github
from diagrams.aws.storage import S3
from diagrams.oci.storage import DatatransferGrey


with Diagram("architecture", outformat="png", show=False):
    users = Users("user")   
    client = Client("browser")
    cdn = CdnGrey("Cloudflare")
    developer = Client("developer")

    with Cluster("Application"):
        with Cluster("Heroku dyno"):
            websrv = Vue("web server")
            webapisrv = Django("web api server")

        with Cluster("Heroku Database"):
            db = PostgreSQL("DB")
        
        webapisrv >> db

        with Cluster("AWS"):
            s3 = S3("S3")
        websrv >> s3

    with Cluster("CI/CD"):
        ci = Circleci("circleci")
        github = Github("github")
        ci << github
    
    with Cluster("Analytics"):
        ga = DatatransferGrey("google analytics")

    users >> client >> s3
    client >> cdn >> [webapisrv,websrv] << ci
    client >> ga
    github << developer
    ga << developer
