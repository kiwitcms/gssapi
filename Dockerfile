# Copyright (c) 2026 Alexander Todorov <atodorov@otb.bg>
#
# Licensed under GNU Affero General Public License v3 or later (AGPLv3+)
# https://www.gnu.org/licenses/agpl-3.0.html

FROM kiwitcms/kiwi AS buildroot

USER 0
RUN dnf -y install gcc krb5-devel python3.12-devel

USER 1001
COPY ./requirements.txt /Kiwi/requirements.txt
RUN pip3 install --no-cache-dir --upgrade pip wheel
RUN pip3 wheel --no-deps --wheel-dir /Kiwi/dist -r /Kiwi/requirements.txt

FROM scratch AS pkg-dist
COPY --from=buildroot /Kiwi/dist/ /
