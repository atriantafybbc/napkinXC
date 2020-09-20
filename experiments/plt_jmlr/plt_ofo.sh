#!/usr/bin/env bash

EXP_DIR=$( dirname "${BASH_SOURCE[0]}" )/..

MODEL=models_plt_ofo
RESULTS=results_plt_ofo

SEEDS=(1993 2020 2029 2047 2077)
for s in "${SEEDS[@]}"; do
    bash ${EXP_DIR}/split_dataset.sh eurlex 30 ${s}
    bash ${EXP_DIR}/split_dataset.sh amazonCat 30 ${s}
    bash ${EXP_DIR}/split_dataset.sh wiki10 30 ${s}
    bash ${EXP_DIR}/split_dataset.sh deliciousLarge 30 ${s}
    bash ${EXP_DIR}/split_dataset.sh wikiLSHTC 30 ${s}
    bash ${EXP_DIR}/split_dataset.sh WikipediaLarge-500K 30 ${s}
    bash ${EXP_DIR}/split_dataset.sh amazon 30 ${s}
    bash ${EXP_DIR}/split_dataset.sh amazon-3M 30 ${s}
done

BASE_TRAIN_ARGS="-m plt --eps 0.1"
BASE_TEST_ARGS="--measures p@1,hl,microf1,macrof1,samplef1,s"
OFO_ARGS="--ofoType micro --ofoA 10 --ofoB 20 --epochs 1"

for s in "${SEEDS[@]}"; do
    bash ${EXP_DIR}/test_ofo.sh eurlex_split_--seed_${s} "${BASE_TRAIN_ARGS} -c 12" " ${OFO_ARGS}" "${BASE_TEST_ARGS}" $MODEL $RESULTS
    bash ${EXP_DIR}/test_ofo.sh wiki10_split_--seed_${s} "${BASE_TRAIN_ARGS} -c 16" " ${OFO_ARGS}" "${BASE_TEST_ARGS}" $MODEL $RESULTS
    bash ${EXP_DIR}/test_ofo.sh amazonCat_split_--seed_${s} "${BASE_TRAIN_ARGS} -c 8" " ${OFO_ARGS}" "${BASE_TEST_ARGS}" $MODEL $RESULTS
    bash ${EXP_DIR}/test_ofo.sh deliciousLarge_split_--seed_${s} "${BASE_TRAIN_ARGS} -c 1" " ${OFO_ARGS}" "${BASE_TEST_ARGS}" $MODEL $RESULTS
    bash ${EXP_DIR}/test_ofo.sh wikiLSHTC_split_--seed_${s} "${BASE_TRAIN_ARGS} -c 32" " ${OFO_ARGS}" "${BASE_TEST_ARGS}" $MODEL $RESULTS
    bash ${EXP_DIR}/test_ofo.sh WikipediaLarge-500K_split_--seed_${s} "${BASE_TRAIN_ARGS} -c 32" " ${OFO_ARGS}" "${BASE_TEST_ARGS}" $MODEL $RESULTS
    bash ${EXP_DIR}/test_ofo.sh amazon_split_--seed_${s} "${BASE_TRAIN_ARGS} -c 16" " ${OFO_ARGS}" "${BASE_TEST_ARGS}" $MODEL $RESULTS
    bash ${EXP_DIR}/test_ofo.sh amazon-3M_split_--seed_${s} "${BASE_TRAIN_ARGS} -c 8" " ${OFO_ARGS}" "${BASE_TEST_ARGS}" $MODEL $RESULTS

    # k = avg. #labels per example
    bash ${EXP_DIR}/test.sh eurlex "${BASE_TRAIN_ARGS} -c 12 --seed ${s}" "--topK 5 ${BASE_TEST_ARGS}" $MODEL $RESULTS
    bash ${EXP_DIR}/test.sh wiki10 "${BASE_TRAIN_ARGS} -c 16 --seed ${s}" "--topK 5 ${BASE_TEST_ARGS}" $MODEL $RESULTS
    bash ${EXP_DIR}/test.sh amazonCat "${BASE_TRAIN_ARGS} -c 8 --seed ${s}" "--topK 19 ${BASE_TEST_ARGS}" $MODEL $RESULTS
    bash ${EXP_DIR}/test.sh deliciousLarge "${BASE_TRAIN_ARGS} -c 1 --seed ${s}" "--topK 76 ${BASE_TEST_ARGS}" $MODEL $RESULTS
    bash ${EXP_DIR}/test.sh wikiLSHTC "${BASE_TRAIN_ARGS} -c 32 --seed ${s}" "--topK 3 ${BASE_TEST_ARGS}" $MODEL $RESULTS
    bash ${EXP_DIR}/test.sh WikipediaLarge-500K "${BASE_TRAIN_ARGS} -c 32 --seed ${s}" "--topK 5 ${BASE_TEST_ARGS}" $MODEL $RESULTS
    bash ${EXP_DIR}/test.sh amazon "${BASE_TRAIN_ARGS} -c 16 --seed ${s}" "--topK 5 ${BASE_TEST_ARGS}" $MODEL $RESULTS
    bash ${EXP_DIR}/test.sh amazon-3M "${BASE_TRAIN_ARGS} -c 8 --seed ${s}" "--topK 36 ${BASE_TEST_ARGS}" $MODEL $RESULTS

    # prediction with threshold = 0.5
    bash ${EXP_DIR}/test.sh eurlex "${BASE_TRAIN_ARGS} -c 12 --seed ${s}" "--threshold 0.5 ${BASE_TEST_ARGS}" $MODEL $RESULTS
    bash ${EXP_DIR}/test.sh wiki10 "${BASE_TRAIN_ARGS} -c 16 --seed ${s}" "--threshold 0.5 ${BASE_TEST_ARGS}" $MODEL $RESULTS
    bash ${EXP_DIR}/test.sh amazonCat "${BASE_TRAIN_ARGS} -c 8 --seed ${s}" "--threshold 0.5 ${BASE_TEST_ARGS}" $MODEL $RESULTS
    bash ${EXP_DIR}/test.sh deliciousLarge "${BASE_TRAIN_ARGS} -c 1 --seed ${s}" "--threshold 0.5 ${BASE_TEST_ARGS}" $MODEL $RESULTS
    bash ${EXP_DIR}/test.sh wikiLSHTC "${BASE_TRAIN_ARGS} -c 32 --seed ${s}" "--threshold 0.5 ${BASE_TEST_ARGS}" $MODEL $RESULTS
    bash ${EXP_DIR}/test.sh WikipediaLarge-500K "${BASE_TRAIN_ARGS} -c 32 --seed ${s}" "--threshold 0.5 ${BASE_TEST_ARGS}" $MODEL $RESULTS
    bash ${EXP_DIR}/test.sh amazon "${BASE_TRAIN_ARGS} -c 16 --seed ${s}" "--threshold 0.5 ${BASE_TEST_ARGS}" $MODEL $RESULTS
    bash ${EXP_DIR}/test.sh amazon-3M "${BASE_TRAIN_ARGS} -c 8 --seed ${s}" "--threshold 0.5 ${BASE_TEST_ARGS}" $MODEL $RESULTS
done