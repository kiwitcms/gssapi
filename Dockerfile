# Copyright (c) 2026 Alexander Todorov <atodorov@otb.bg>
#
# Licensed under GNU Affero General Public License v3 or later (AGPLv3+)
# https://www.gnu.org/licenses/agpl-3.0.html

FROM registry.access.redhat.com/ubi10-minimal AS buildroot

RUN microdnf -y install gcc krb5-devel python3.12-devel
ENV PATH=/venv/bin:${PATH} \
    VIRTUAL_ENV=/venv
RUN python3.12 -m venv /venv

COPY ./requirements.txt /Kiwi/requirements.txt
RUN pip3 install --no-cache-dir --upgrade pip twine wheel
RUN pip3 wheel --no-deps --wheel-dir /Kiwi/dist -r /Kiwi/requirements.txt
RUN twine check /Kiwi/dist/* || exit 1

FROM scratch AS pkg-dist
COPY --from=buildroot /Kiwi/dist/ /
